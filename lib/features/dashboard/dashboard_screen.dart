import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/edit_delete_slidable.dart';
import '../../data/models/budget_period.dart';
import '../../providers/budget_settings_provider.dart';
import '../../providers/category_provider.dart';
import '../../providers/expense_provider.dart';
import '../../providers/juice_theme_provider.dart';
import '../../providers/period_budget_provider.dart';
import '../categories/category_manage_screen.dart';
import 'widgets/add_expense_sheet.dart';
import 'widgets/expense_actions.dart';
import 'widgets/expense_tile.dart';
import 'widgets/juice_gauge.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetAmount = ref.watch(targetAmountProvider);
    if (targetAmount == null) return const SizedBox.shrink();

    final spent = ref.watch(periodSpentProvider);
    final remaining = (targetAmount - spent).clamp(0, targetAmount).toDouble();
    final ratio = ref.watch(periodRemainingRatioProvider);
    final period = ref.watch(budgetPeriodProvider);
    final juiceTheme = ref.watch(resolvedJuiceThemeProvider);
    final filter = ref.watch(expenseFilterProvider);
    final expenses = ref.watch(filteredPeriodExpensesProvider);
    final categories = ref.watch(categoryProvider);
    final categoryMap = {for (final c in categories) c.id: c};

    return Scaffold(
      appBar: AppBar(
        title: const Text('주스'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sell_outlined),
            tooltip: '카테고리 관리',
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
              periodLabel: period.label,
              color: juiceTheme.getColorByRatio(ratio),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SegmentedButton<ExpenseFilter>(
              segments: const [
                ButtonSegment(value: ExpenseFilter.variableOnly, label: Text('변동지출만 보기')),
                ButtonSegment(value: ExpenseFilter.all, label: Text('전체 내역 보기')),
              ],
              selected: {filter},
              onSelectionChanged: (selection) =>
                  ref.read(expenseFilterProvider.notifier).state = selection.first,
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
                        onEdit: () => showAddExpenseSheet(context, editingExpense: expense),
                        onDelete: () => deleteExpenseWithUndo(context, ref, expense),
                        child: ExpenseTile(
                          expense: expense,
                          category: category,
                          onTap: () => showAddExpenseSheet(context, editingExpense: expense),
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

class _EmptyExpenseList extends StatelessWidget {
  const _EmptyExpenseList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '아직 기록된 지출이 없어요',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
