import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/week_utils.dart';
import '../data/models/expense.dart';
import 'expense_provider.dart';

/// 캘린더 탭에서 현재 보고 있는 달(항상 1일로 정규화).
final calendarFocusedMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 1);
});

/// 캘린더에서 선택된 날짜(시각 제외).
final calendarSelectedDayProvider =
    StateProvider<DateTime>((ref) => dateOnly(DateTime.now()));

/// 캘린더 탭 전용 지출 필터: 변동지출만 vs 전체(고정지출 포함).
final calendarExpenseFilterProvider =
    StateProvider<ExpenseFilter>((ref) => ExpenseFilter.variableOnly);

final calendarMonthRangeProvider = Provider<DateRange>((ref) {
  final month = ref.watch(calendarFocusedMonthProvider);
  return monthRange(month.year, month.month);
});

/// 이번 달 지출+수입 항목(필터는 지출에만 적용, 수입은 항상 포함).
final calendarMonthItemsProvider = Provider<List<Expense>>((ref) {
  final all = ref.watch(expenseProvider);
  final range = ref.watch(calendarMonthRangeProvider);
  final filter = ref.watch(calendarExpenseFilterProvider);
  return all.where((e) {
    if (!range.contains(e.date)) return false;
    if (!e.isIncome && filter == ExpenseFilter.variableOnly && e.isFixed)
      return false;
    return true;
  }).toList();
});

/// 이번 달 총 지출(필터 반영, 수입 제외).
final calendarMonthTotalProvider = Provider<double>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  return items.where((e) => !e.isIncome).fold(0.0, (sum, e) => sum + e.amount);
});

/// 이번 달 총 수입.
final calendarMonthIncomeTotalProvider = Provider<double>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  return items.where((e) => e.isIncome).fold(0.0, (sum, e) => sum + e.amount);
});

/// 날짜(시각 제외)별 지출 합계 — 캘린더 셀에 표시(수입 제외).
final calendarDailyTotalsProvider = Provider<Map<DateTime, double>>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  final totals = <DateTime, double>{};
  for (final e in items) {
    if (e.isIncome) continue;
    final day = dateOnly(e.date);
    totals.update(day, (v) => v + e.amount, ifAbsent: () => e.amount);
  }
  return totals;
});

/// 날짜(시각 제외)별 수입이 있었는지 여부 — 캘린더 셀 마커에 사용.
final calendarDailyIncomeMarkersProvider = Provider<Set<DateTime>>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  return items.where((e) => e.isIncome).map((e) => dateOnly(e.date)).toSet();
});

/// 그 날 지출이 전부 신용카드 할부 분할액으로만 이뤄진 날짜 집합.
/// 캘린더 셀에서 고정지출처럼 옅은 색상으로 표시하는 데 사용.
final calendarDailyInstallmentOnlyDaysProvider = Provider<Set<DateTime>>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  final byDay = <DateTime, List<bool>>{};
  for (final e in items) {
    if (e.isIncome) continue;
    final day = dateOnly(e.date);
    (byDay[day] ??= []).add(e.isInstallment);
  }
  return byDay.entries
      .where((entry) => entry.value.every((isInstallment) => isInstallment))
      .map((entry) => entry.key)
      .toSet();
});

/// 선택된 날짜의 지출+수입 내역(최신순).
final calendarSelectedDayItemsProvider = Provider<List<Expense>>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  final selected = ref.watch(calendarSelectedDayProvider);
  return items.where((e) => dateOnly(e.date) == selected).toList()
    ..sort((a, b) => b.date.compareTo(a.date));
});
