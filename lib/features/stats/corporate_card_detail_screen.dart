import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/edit_delete_slidable.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/category_provider.dart';
import '../../providers/corporate_card_provider.dart';
import '../../providers/currency_provider.dart';
import '../dashboard/widgets/add_expense_sheet.dart';
import '../dashboard/widgets/expense_actions.dart';
import '../dashboard/widgets/expense_tile.dart';
import 'widgets/trend_bar_chart.dart';

/// 통계 화면의 '법인/업무용 카드' 행을 탭하면 열리는 전용 상세 화면. 개인 지출 통계와는
/// 완전히 분리된 월별 추이 + 전체 영수증 내역(최신순)을 보여준다.
class CorporateCardDetailScreen extends ConsumerWidget {
  const CorporateCardDetailScreen({super.key});

  static const _color = Colors.blueGrey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final currency = ref.watch(currencyProvider).currency;
    final expenses = ref.watch(corporateExpensesProvider);
    final thisMonthTotal = ref.watch(corporateThisMonthTotalProvider);
    final categories = ref.watch(categoryProvider);
    final categoryMap = {for (final c in categories) c.id: c};

    return Scaffold(
      appBar: AppBar(title: Text(loc.corporateCardLabel)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: _color.withValues(alpha: 0.18),
                  child: const Icon(Icons.business, color: _color),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loc.categoryDetailThisMonthTotal,
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(currency.format(thisMonthTotal),
                        style: Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(loc.categoryDetailMonthlyTrendTitle,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TrendBarChart(
                trend: ref.watch(corporateMonthlyTrendProvider),
                color: _color),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(loc.categoryDetailExpenseListTitle,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          Expanded(
            child: expenses.isEmpty
                ? Center(
                    child: Text(loc.categoryDetailEmptyMessage,
                        style: Theme.of(context).textTheme.bodyMedium),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                    itemCount: expenses.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return EditDeleteSlidable(
                        key: ValueKey(expense.id),
                        onEdit: () => showAddExpenseSheet(context,
                            editingExpense: expense),
                        onDelete: () =>
                            deleteExpenseWithUndo(context, ref, expense),
                        child: ExpenseTile(
                          expense: expense,
                          category: categoryMap[expense.categoryId],
                          onTap: () => showAddExpenseSheet(context,
                              editingExpense: expense),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
