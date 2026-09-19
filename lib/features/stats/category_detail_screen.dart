import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
/// 월별 추이 막대를 탭해 선택한 달의 합계/내역을 볼 수 있다(기본값: 이번 달).
class CategoryDetailScreen extends ConsumerStatefulWidget {
  const CategoryDetailScreen(
      {super.key, required this.categoryId, required this.category});

  final String categoryId;

  /// null이면 삭제된 카테고리 등 — 이름/아이콘/색은 폴백으로 대체하되 내역은 그대로 보여준다.
  final Category? category;

  @override
  ConsumerState<CategoryDetailScreen> createState() =>
      _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends ConsumerState<CategoryDetailScreen> {
  late DateTime _selectedMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month, 1);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final category = widget.category;
    final currency = ref.watch(currencyProvider).currency;
    final allExpenses =
        ref.watch(categoryDetailExpensesProvider(widget.categoryId));
    final trend =
        ref.watch(categoryDetailMonthlyTrendProvider(widget.categoryId));
    final now = DateTime.now();
    final isCurrentMonth = _selectedMonth.year == now.year &&
        _selectedMonth.month == now.month;
    final selectedIndex = trend.length - 1 -
        ((now.year - _selectedMonth.year) * 12 +
            (now.month - _selectedMonth.month));
    final expenses = allExpenses
        .where((e) =>
            e.date.year == _selectedMonth.year &&
            e.date.month == _selectedMonth.month)
        .toList();
    final selectedTotal =
        expenses.fold(0.0, (sum, e) => sum + e.amount);
    final monthLabel = isCurrentMonth
        ? loc.categoryDetailThisMonthTotal
        : loc.monthlyTotalLabel(
            DateFormat.MMM(loc.localeName).format(_selectedMonth));

    void selectMonth(int index) {
      final monthDate = DateTime(now.year, now.month - 5 + index, 1);
      setState(() => _selectedMonth = monthDate);
    }

    final color =
        category != null ? Color(category.colorValue) : Colors.grey;
    final icon = category != null
        ? IconData(category.iconCodePoint,
            fontFamily: category.iconFontFamily ?? 'MaterialIcons')
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
                    Text(monthLabel,
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(currency.format(selectedTotal),
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
                trend: trend,
                color: color,
                selectedIndex: selectedIndex,
                onSelect: selectMonth),
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
                    child: Text(
                        allExpenses.isEmpty
                            ? loc.categoryDetailEmptyMessage
                            : loc.categoryDetailEmptyMonthMessage,
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
