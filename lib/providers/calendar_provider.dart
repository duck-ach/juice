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
    StateProvider<ExpenseFilter>((ref) => ExpenseFilter.all);

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
    // 법인/업무용 카드 지출은 고정비 취급(isFixed=true)이지만 "변동지출만" 토글과는
    // 무관하게 항상 상세 내역에 보여야 하므로(개인 지출 금액에서만 제외) 이 필터에서 예외.
    if (!e.isIncome &&
        !e.isCorporate &&
        filter == ExpenseFilter.variableOnly &&
        e.isFixed) {
      return false;
    }
    return true;
  }).toList();
});

/// 이번 달 총 지출(필터 반영, 수입·저축·법인/업무용 카드 제외 — 저축은 소비가 아닌 자산
/// 이동, 법인카드는 개인 지출과 완전히 분리되는 별도 금액).
final calendarMonthTotalProvider = Provider<double>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  return items
      .where((e) => !e.isIncome && !e.isSavings && !e.isCorporate)
      .fold(0.0, (sum, e) => sum + e.amount);
});

/// 이번 달 총 수입.
final calendarMonthIncomeTotalProvider = Provider<double>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  return items.where((e) => e.isIncome).fold(0.0, (sum, e) => sum + e.amount);
});

/// 이번 달 총 저축/투자.
final calendarMonthSavingsTotalProvider = Provider<double>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  return items.where((e) => e.isSavings).fold(0.0, (sum, e) => sum + e.amount);
});

/// 날짜(시각 제외)별 지출 합계 — 캘린더 셀에 표시(수입·저축·법인/업무용 카드 제외).
final calendarDailyTotalsProvider = Provider<Map<DateTime, double>>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  final totals = <DateTime, double>{};
  for (final e in items) {
    if (e.isIncome || e.isSavings || e.isCorporate) continue;
    final day = dateOnly(e.date);
    totals.update(day, (v) => v + e.amount, ifAbsent: () => e.amount);
  }
  return totals;
});

/// 법인/업무용 카드 결제가 있는 날짜 집합 — 캘린더 셀에 전용 스탬프(🏢)를 찍는 데 사용.
final calendarDailyCorporateDaysProvider = Provider<Set<DateTime>>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  return {
    for (final e in items)
      if (e.isCorporate) dateOnly(e.date),
  };
});

/// 날짜(시각 제외)별 수입 합계 — 캘린더 셀에 표시(지출 제외).
final calendarDailyIncomeTotalsProvider = Provider<Map<DateTime, double>>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  final totals = <DateTime, double>{};
  for (final e in items) {
    if (!e.isIncome) continue;
    final day = dateOnly(e.date);
    totals.update(day, (v) => v + e.amount, ifAbsent: () => e.amount);
  }
  return totals;
});

/// 날짜(시각 제외)별 저축/투자 합계 — 캘린더 셀에 표시(지출·수입과 완전히 분리 집계).
final calendarDailySavingsTotalsProvider = Provider<Map<DateTime, double>>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  final totals = <DateTime, double>{};
  for (final e in items) {
    if (!e.isSavings) continue;
    final day = dateOnly(e.date);
    totals.update(day, (v) => v + e.amount, ifAbsent: () => e.amount);
  }
  return totals;
});

/// '무지출 성공' 날짜 집합 — 오늘까지의 날짜 중 순수 변동 지출(할부·고정지출 제외)이
/// 0원인 날. 수입만 있거나 기록이 아예 없는 날도 포함된다. 미래 날짜는 제외.
final calendarNoSpendDaysProvider = Provider<Set<DateTime>>((ref) {
  final month = ref.watch(calendarFocusedMonthProvider);
  final items = ref.watch(calendarMonthItemsProvider);
  final today = dateOnly(DateTime.now());

  final spendDays = <DateTime>{
    for (final e in items)
      if (!e.isIncome &&
          !e.isSavings &&
          !e.isFixed &&
          !e.isInstallment &&
          !e.isCorporate)
        dateOnly(e.date),
  };

  final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
  final noSpendDays = <DateTime>{};
  for (var d = 1; d <= daysInMonth; d++) {
    final day = DateTime(month.year, month.month, d);
    if (day.isAfter(today)) continue;
    if (!spendDays.contains(day)) noSpendDays.add(day);
  }
  return noSpendDays;
});

/// 그 날 지출이 전부 신용카드 할부 분할액으로만 이뤄진 날짜 집합.
/// 캘린더 셀에서 고정지출처럼 옅은 색상으로 표시하는 데 사용.
final calendarDailyInstallmentOnlyDaysProvider = Provider<Set<DateTime>>((ref) {
  final items = ref.watch(calendarMonthItemsProvider);
  final byDay = <DateTime, List<bool>>{};
  for (final e in items) {
    if (e.isIncome || e.isSavings) continue;
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
