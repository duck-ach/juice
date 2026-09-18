import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/edit_delete_slidable.dart';
import '../../data/models/category.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/category_detail_provider.dart';
import '../../providers/currency_provider.dart';
import '../dashboard/widgets/add_expense_sheet.dart';
import '../dashboard/widgets/expense_actions.dart';
import '../dashboard/widgets/expense_tile.dart';
import 'widgets/trend_bar_chart.dart';

/// 통계 화면의 카테고리별 소비(도넛 차트/범례)에서 카테고리를 탭하면 열리는 상세 화면.
/// 이번 달 합계, 최근 6개월 추이, 이 카테고리로 기록된 전체 내역을 보여준다.
class CategoryDetailScreen extends ConsumerWidget {
  const CategoryDetailScreen(
      {super.key, required this.categoryId, required this.category});

  final String categoryId;

  /// null이면 삭제된 카테고리 등 — 이름/아이콘/색은 폴백으로 대체하되 내역은 그대로 보여준다.
  final Category? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final currency = ref.watch(currencyProvider).currency;
    final expenses = ref.watch(categoryDetailExpensesProvider(categoryId));
    final thisMonthTotal =
        ref.watch(categoryDetailThisMonthTotalProvider(categoryId));

    final color =
        category != null ? Color(category!.colorValue) : Colors.grey;
    final icon = category != null
        ? IconData(category!.iconCodePoint,
            fontFamily: category!.iconFontFamily ?? 'MaterialIcons')
        : Icons.help_outline;
    final name = category?.getLocalizedName(context) ?? loc.unknownCategoryName;

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: color.withValues(alpha: 0.18),
                  child: Icon(icon, color: color),
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
                trend: ref.watch(categoryDetailMonthlyTrendProvider(categoryId)),
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
    );
  }
}
