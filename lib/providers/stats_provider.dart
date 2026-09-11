import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/week_utils.dart';
import '../data/models/category.dart';
import '../data/models/expense.dart';
import '../data/models/payment_method.dart';
import 'budget_settings_provider.dart';
import 'category_provider.dart';
import 'expense_provider.dart';

enum StatsPeriod { thisWeek, thisMonth, last4Weeks, monthly, yearly }

extension StatsPeriodLabel on StatsPeriod {
  String get label => switch (this) {
        StatsPeriod.thisWeek => '이번 주',
        StatsPeriod.thisMonth => '이번 달',
        StatsPeriod.last4Weeks => '최근 4주',
        StatsPeriod.monthly => '월별',
        StatsPeriod.yearly => '연도별',
      };

  bool get isTrend => this == StatsPeriod.monthly || this == StatsPeriod.yearly;
}

final statsPeriodProvider =
    StateProvider<StatsPeriod>((ref) => StatsPeriod.thisWeek);

/// 통계 화면 전용 지출 필터: 변동지출만 vs 고정비 포함.
final statsExpenseFilterProvider =
    StateProvider<ExpenseFilter>((ref) => ExpenseFilter.variableOnly);

/// 선택된 기간에 해당하는 날짜 범위. 월별/연도별은 차트가 보여주는 전체 범위
/// (각각 올해, 최근 5년)를 카테고리별 도넛 차트 집계에도 함께 사용한다.
final statsDateRangeProvider = Provider<DateRange>((ref) {
  final period = ref.watch(statsPeriodProvider);
  final weekStartDay = ref.watch(weekStartDayProvider);
  return switch (period) {
    StatsPeriod.thisWeek => currentWeekRange(null, weekStartDay),
    StatsPeriod.thisMonth => currentMonthRange(),
    StatsPeriod.last4Weeks => last4WeeksRange(null, weekStartDay),
    StatsPeriod.monthly => currentYearRange(),
    StatsPeriod.yearly => lastNYearsRange(5),
  };
});

/// 지출 통계는 수입 기록을 집계하지 않는다.
final statsFilteredExpensesProvider = Provider<List<Expense>>((ref) {
  final all = ref.watch(expenseProvider);
  final range = ref.watch(statsDateRangeProvider);
  final filter = ref.watch(statsExpenseFilterProvider);
  return all.where((e) {
    if (e.isIncome) return false;
    if (!range.contains(e.date)) return false;
    if (filter == ExpenseFilter.variableOnly && e.isFixed) return false;
    return true;
  }).toList();
});

class CategoryAmount {
  const CategoryAmount(
      {required this.category, required this.amount, required this.percent});

  final Category? category;
  final double amount;
  final double percent;
}

/// 선택된 기간 + 필터 기준 카테고리별 합계(내림차순).
final categoryBreakdownProvider = Provider<List<CategoryAmount>>((ref) {
  final expenses = ref.watch(statsFilteredExpensesProvider);
  final categories = ref.watch(categoryProvider);
  final categoryMap = {for (final c in categories) c.id: c};

  final totals = <String, double>{};
  for (final e in expenses) {
    totals.update(e.categoryId, (v) => v + e.amount, ifAbsent: () => e.amount);
  }
  final total = totals.values.fold(0.0, (a, b) => a + b);

  final result = totals.entries
      .map((entry) => CategoryAmount(
            category: categoryMap[entry.key],
            amount: entry.value,
            percent: total <= 0 ? 0 : entry.value / total,
          ))
      .toList()
    ..sort((a, b) => b.amount.compareTo(a.amount));
  return result;
});

class PaymentMethodAmount {
  const PaymentMethodAmount(
      {required this.method, required this.amount, required this.percent});

  final PaymentMethod method;
  final double amount;
  final double percent;
}

/// 선택된 기간 + 필터 기준 결제 수단별 합계(체크카드/신용카드/현금 고정 순서).
/// 신용카드 할부로 분할된 레코드는 각자의 날짜에 이미 신용카드로 집계되므로
/// 청구월의 할부금이 자동으로 포함된다.
final paymentMethodBreakdownProvider =
    Provider<List<PaymentMethodAmount>>((ref) {
  final expenses = ref.watch(statsFilteredExpensesProvider);
  final totals = {for (final m in PaymentMethod.values) m: 0.0};
  for (final e in expenses) {
    totals[e.paymentMethod] = (totals[e.paymentMethod] ?? 0) + e.amount;
  }
  final total = totals.values.fold(0.0, (a, b) => a + b);
  return PaymentMethod.values
      .map((m) => PaymentMethodAmount(
            method: m,
            amount: totals[m] ?? 0,
            percent: total <= 0 ? 0 : (totals[m] ?? 0) / total,
          ))
      .toList();
});

class TrendPoint {
  const TrendPoint({required this.label, required this.amount});

  final String label;
  final double amount;
}

/// 월별(올해 1~12월) / 연도별(최근 5년) 지출 추이. 다른 기간에서는 빈 리스트.
final trendProvider = Provider<List<TrendPoint>>((ref) {
  final period = ref.watch(statsPeriodProvider);
  final all = ref.watch(expenseProvider);
  final filter = ref.watch(statsExpenseFilterProvider);
  final filtered = all
      .where((e) => !e.isIncome && (filter == ExpenseFilter.all || !e.isFixed));

  if (period == StatsPeriod.monthly) {
    final year = DateTime.now().year;
    return List.generate(12, (i) {
      final month = i + 1;
      final amount = filtered
          .where((e) => e.date.year == year && e.date.month == month)
          .fold(0.0, (sum, e) => sum + e.amount);
      return TrendPoint(label: '$month월', amount: amount);
    });
  }

  if (period == StatsPeriod.yearly) {
    final currentYear = DateTime.now().year;
    return List.generate(5, (i) {
      final year = currentYear - 4 + i;
      final amount = filtered
          .where((e) => e.date.year == year)
          .fold(0.0, (sum, e) => sum + e.amount);
      return TrendPoint(label: '$year', amount: amount);
    });
  }

  return const [];
});
