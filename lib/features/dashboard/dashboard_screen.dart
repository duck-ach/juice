import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/widgets/edit_delete_slidable.dart';
import '../../core/widgets/juice_segmented_tab.dart';
import '../../data/models/budget_period.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/budget_settings_provider.dart';
import '../../providers/category_provider.dart';
import '../../providers/expense_provider.dart';
import '../../providers/juice_theme_provider.dart';
import '../../providers/period_budget_provider.dart';
import '../categories/category_manage_screen.dart';
import '../settings/goal_settings_screen.dart';
import 'widgets/add_expense_sheet.dart';
import 'widgets/expense_actions.dart';
import 'widgets/expense_tile.dart';
import 'widgets/juice_gauge.dart';
import 'widgets/juice_tip_card.dart';
import 'widgets/saving_history_bottom_sheet.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final targetAmount = ref.watch(effectiveTargetAmountProvider);
    final period = ref.watch(budgetPeriodProvider);
    if (targetAmount == null) return _NoGoalForPeriod(period: period);

    final spent = ref.watch(periodSpentProvider);
    final remaining = targetAmount - spent;
    final isOverBudget = spent > targetAmount;
    final ratio = ref.watch(periodRemainingRatioProvider);
    final juiceTheme = ref.watch(resolvedJuiceThemeProvider);
    final gaugeColor = isOverBudget
        ? const Color(0xFFFF3B30)
        : juiceTheme.getColorByRatio(ratio);
    final filter = ref.watch(expenseFilterProvider);
    final expenses = ref.watch(filteredPeriodExpensesProvider);
    final categories = ref.watch(categoryProvider);
    final categoryMap = {for (final c in categories) c.id: c};
    final todayInstallment = ref.watch(todayInstallmentPortionProvider);
    final rolloverBonus = ref.watch(rolloverBonusProvider);
    final formatter = NumberFormat('#,###');

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        leading: IconButton(
          icon: const Icon(Icons.savings_outlined),
          tooltip: loc.savedJuiceStoreTooltip,
          onPressed: () => SavingHistoryBottomSheet.show(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sell_outlined),
            tooltip: loc.categoryManageTitle,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CategoryManageScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
            child: JuiceGauge(
              remainingRatio: ratio,
              remaining: remaining,
              total: targetAmount,
              periodLabel: period.label(loc),
              color: gaugeColor,
              isOverBudget: isOverBudget,
            ),
          ),
          const SizedBox(height: 4),
          if (rolloverBonus > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: juiceTheme.highColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    loc.rolloverBonusLabel(formatter.format(rolloverBonus)),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: juiceTheme.highColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          if (todayInstallment > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    loc.todayInstallmentLabel(formatter.format(todayInstallment)),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: JuiceTipCard(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: JuiceSegmentedTab(
              items: [loc.filterVariableOnlyLong, loc.filterAllLong],
              selectedIndex: ExpenseFilter.values.indexOf(filter),
              onTabChanged: (index) => ref
                  .read(expenseFilterProvider.notifier)
                  .state = ExpenseFilter.values[index],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: expenses.isEmpty
                ? const _EmptyExpenseList()
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 96),
                    itemCount: expenses.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      final category = categoryMap[expense.categoryId];
                      return EditDeleteSlidable(
                        key: ValueKey(expense.id),
                        onEdit: () => showAddExpenseSheet(context,
                            editingExpense: expense),
                        onDelete: () =>
                            deleteExpenseWithUndo(context, ref, expense),
                        child: ExpenseTile(
                          expense: expense,
                          category: category,
                          onTap: () => showAddExpenseSheet(context,
                              editingExpense: expense),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'dashboard_fab',
        onPressed: () => showAddExpenseSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// 현재 활성 주기(일간/주간/월간)의 목표 금액이 아직 없을 때 보여주는 안내 화면.
/// 주기를 바꿔가며 사용하다 보면 아직 채우지 않은 주기가 있을 수 있어, 빈 화면 대신
/// 목표 설정으로 바로 이동할 수 있는 버튼을 보여준다.
class _NoGoalForPeriod extends StatelessWidget {
  const _NoGoalForPeriod({required this.period});

  final BudgetPeriod period;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.appTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🍊', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 16),
              Text(
                loc.noGoalTitle(period.label(loc)),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                loc.noGoalDescription(period.settingLabel(loc)),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const GoalSettingsScreen()),
                ),
                child: Text(loc.goToGoalSettings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyExpenseList extends StatelessWidget {
  const _EmptyExpenseList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.noExpensesYet,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
