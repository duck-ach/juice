import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/week_utils.dart';
import '../data/models/card_item.dart';
import '../data/models/category.dart';
import '../data/models/expense.dart';
import '../data/models/payment_method.dart';
import '../l10n/app_localizations.dart';
import 'budget_settings_provider.dart';
import 'card_provider.dart';
import 'category_provider.dart';
import 'expense_provider.dart';

enum StatsPeriod { thisWeek, thisMonth, last4Weeks, monthly, yearly }

extension StatsPeriodLabel on StatsPeriod {
  String label(AppLocalizations loc) => switch (this) {
        StatsPeriod.thisWeek => loc.statsPeriodThisWeek,
        StatsPeriod.thisMonth => loc.statsPeriodThisMonth,
        StatsPeriod.last4Weeks => loc.statsPeriodLast4Weeks,
        StatsPeriod.monthly => loc.statsPeriodMonthly,
        StatsPeriod.yearly => loc.statsPeriodYearly,
      };

  bool get isTrend => this == StatsPeriod.monthly || this == StatsPeriod.yearly;
}

final statsPeriodProvider =
    StateProvider<StatsPeriod>((ref) => StatsPeriod.thisWeek);

/// 통계 화면 대분류: 지출/수입/저축 중 어느 흐름을 보고 있는지.
enum StatsCategory { expense, income, savings }

final statsCategoryProvider =
    StateProvider<StatsCategory>((ref) => StatsCategory.expense);

/// 통계 화면 전용 지출 필터: 변동지출만 vs 고정비 포함. [StatsCategory.expense]에서만 쓰인다.
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

/// 선택된 [statsCategoryProvider](지출/수입/저축)에 맞는 기록만 남긴다. 지출 탭은 기존처럼
/// 변동지출만/고정비 포함 필터도 함께 적용.
final statsFilteredExpensesProvider = Provider<List<Expense>>((ref) {
  final all = ref.watch(expenseProvider);
  final range = ref.watch(statsDateRangeProvider);
  final category = ref.watch(statsCategoryProvider);
  final filter = ref.watch(statsExpenseFilterProvider);
  return all.where((e) {
    if (!range.contains(e.date)) return false;
    return switch (category) {
      StatsCategory.expense =>
        !e.isIncome && !e.isSavings &&
            !(filter == ExpenseFilter.variableOnly && e.isFixed),
      StatsCategory.income => e.isIncome,
      StatsCategory.savings => e.isSavings,
    };
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

/// '결제 수단별 소비' 섹션의 표시 방식: 대분류(체크/신용/현금) 요약 vs 카드별 상세.
enum CardStatsView { summary, byCard }

extension CardStatsViewLabel on CardStatsView {
  String label(AppLocalizations loc) => switch (this) {
        CardStatsView.summary => loc.cardStatsViewSummary,
        CardStatsView.byCard => loc.cardStatsViewByCard,
      };
}

final cardStatsViewProvider =
    StateProvider<CardStatsView>((ref) => CardStatsView.summary);

class CardAmount {
  const CardAmount(
      {required this.card, required this.amount, required this.percent});

  /// null이면 카드가 지정되지 않은 지출(현금/더치페이 등) 또는 이미 삭제된 카드.
  final CardItem? card;
  final double amount;
  final double percent;
}

/// 선택된 기간 + 필터 기준 카드별 실사용 합계(내림차순).
final cardBreakdownProvider = Provider<List<CardAmount>>((ref) {
  final expenses = ref.watch(statsFilteredExpensesProvider);
  final cards = ref.watch(cardProvider);
  final cardMap = {for (final c in cards) c.id: c};

  final totals = <String, double>{};
  for (final e in expenses) {
    final key = e.cardId ?? '_none';
    totals.update(key, (v) => v + e.amount, ifAbsent: () => e.amount);
  }
  final total = totals.values.fold(0.0, (a, b) => a + b);

  final result = totals.entries
      .map((entry) => CardAmount(
            card: cardMap[entry.key],
            amount: entry.value,
            percent: total <= 0 ? 0 : entry.value / total,
          ))
      .toList()
    ..sort((a, b) => b.amount.compareTo(a.amount));
  return result;
});

class TrendPoint {
  const TrendPoint({required this.periodValue, required this.amount});

  /// 월별 모드에서는 월(1~12), 연도별 모드에서는 연도(예: 2026).
  /// 화면에 표시할 라벨 문자열은 BuildContext가 있는 위젯 쪽에서 로케일에 맞게 만든다.
  final int periodValue;
  final double amount;
}

/// 월별(올해 1~12월) / 연도별(최근 5년) 지출·수입·저축 추이. 다른 기간에서는 빈 리스트.
final trendProvider = Provider<List<TrendPoint>>((ref) {
  final period = ref.watch(statsPeriodProvider);
  final all = ref.watch(expenseProvider);
  final category = ref.watch(statsCategoryProvider);
  final filter = ref.watch(statsExpenseFilterProvider);
  final filtered = all.where((e) => switch (category) {
        StatsCategory.expense =>
          !e.isIncome && !e.isSavings &&
              (filter == ExpenseFilter.all || !e.isFixed),
        StatsCategory.income => e.isIncome,
        StatsCategory.savings => e.isSavings,
      });

  if (period == StatsPeriod.monthly) {
    final year = DateTime.now().year;
    return List.generate(12, (i) {
      final month = i + 1;
      final amount = filtered
          .where((e) => e.date.year == year && e.date.month == month)
          .fold(0.0, (sum, e) => sum + e.amount);
      return TrendPoint(periodValue: month, amount: amount);
    });
  }

  if (period == StatsPeriod.yearly) {
    final currentYear = DateTime.now().year;
    return List.generate(5, (i) {
      final year = currentYear - 4 + i;
      final amount = filtered
          .where((e) => e.date.year == year)
          .fold(0.0, (sum, e) => sum + e.amount);
      return TrendPoint(periodValue: year, amount: amount);
    });
  }

  return const [];
});
