import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/widgets/edit_delete_slidable.dart';
import '../../data/models/payment_method.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/category_provider.dart';
import '../../providers/currency_provider.dart';
import '../../providers/payment_method_detail_provider.dart';
import '../dashboard/widgets/add_expense_sheet.dart';
import '../dashboard/widgets/expense_actions.dart';
import '../dashboard/widgets/expense_tile.dart';
import 'widgets/payment_method_chart.dart' show paymentMethodColors;
import 'widgets/trend_bar_chart.dart';

/// 통계 화면의 결제 수단별 소비(도넛 차트/범례)에서 수단을 탭하면 열리는 상세 화면.
/// 구성은 [CategoryDetailScreen]과 동일 — 월별 추이 막대를 탭해 선택한 달의
/// 합계/내역을 볼 수 있다(기본값: 이번 달).
class PaymentMethodDetailScreen extends ConsumerStatefulWidget {
  const PaymentMethodDetailScreen({super.key, required this.method});

  final PaymentMethod method;

  @override
  ConsumerState<PaymentMethodDetailScreen> createState() =>
      _PaymentMethodDetailScreenState();
}

class _PaymentMethodDetailScreenState
    extends ConsumerState<PaymentMethodDetailScreen> {
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
    final method = widget.method;
    final currency = ref.watch(currencyProvider).currency;
    final allExpenses =
        ref.watch(paymentMethodDetailExpensesProvider(method));
    final trend = ref.watch(paymentMethodDetailMonthlyTrendProvider(method));
    final now = DateTime.now();
    final isCurrentMonth =
        _selectedMonth.year == now.year && _selectedMonth.month == now.month;
    final selectedIndex = trend.length -
        1 -
        ((now.year - _selectedMonth.year) * 12 +
            (now.month - _selectedMonth.month));
    final expenses = allExpenses
        .where((e) =>
            e.date.year == _selectedMonth.year &&
            e.date.month == _selectedMonth.month)
        .toList();
    final selectedTotal = expenses.fold(0.0, (sum, e) => sum + e.amount);
    final monthLabel = isCurrentMonth
        ? loc.categoryDetailThisMonthTotal
        : loc.monthlyTotalLabel(
            DateFormat.MMM(loc.localeName).format(_selectedMonth));

    void selectMonth(int index) {
      final monthDate = DateTime(now.year, now.month - 5 + index, 1);
      setState(() => _selectedMonth = monthDate);
    }

    final categories = ref.watch(categoryProvider);
    final categoryMap = {for (final c in categories) c.id: c};

    final color = paymentMethodColors[method] ?? Colors.grey;

    return Scaffold(
      appBar: AppBar(title: Text(method.label(loc))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: color.withValues(alpha: 0.18),
                  child: Text(method.emoji, style: const TextStyle(fontSize: 20)),
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
