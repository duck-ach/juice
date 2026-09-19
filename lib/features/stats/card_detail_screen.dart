import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/edit_delete_slidable.dart';
import '../../data/models/card_item.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/card_detail_provider.dart';
import '../../providers/category_provider.dart';
import '../../providers/currency_provider.dart';
import '../dashboard/widgets/add_expense_sheet.dart';
import '../dashboard/widgets/expense_actions.dart';
import '../dashboard/widgets/expense_tile.dart';
import 'widgets/trend_bar_chart.dart';

/// 통계 화면의 '카드별 상세' 리스트에서 카드를 탭하면 열리는 상세 화면.
/// 구성은 [CategoryDetailScreen]/[PaymentMethodDetailScreen]과 동일 — 이번 달 합계,
/// 최근 6개월 추이, 전체 내역.
class CardDetailScreen extends ConsumerWidget {
  const CardDetailScreen({super.key, required this.card});

  final CardItem card;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final currency = ref.watch(currencyProvider).currency;
    final expenses = ref.watch(cardDetailExpensesProvider(card.id));
    final thisMonthTotal = ref.watch(cardDetailThisMonthTotalProvider(card.id));
    final categories = ref.watch(categoryProvider);
    final categoryMap = {for (final c in categories) c.id: c};

    final color = Color(card.colorValue);

    return Scaffold(
      appBar: AppBar(title: Text(card.name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: color.withValues(alpha: 0.18),
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(loc.categoryDetailThisMonthTotal,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            card.type.label(loc),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: color, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
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
                trend: ref.watch(cardDetailMonthlyTrendProvider(card.id)),
                color: color),
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
