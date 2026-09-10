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
final calendarSelectedDayProvider = StateProvider<DateTime>((ref) => dateOnly(DateTime.now()));

/// 캘린더 탭 전용 지출 필터: 변동지출만 vs 전체(고정지출 포함).
final calendarExpenseFilterProvider = StateProvider<ExpenseFilter>((ref) => ExpenseFilter.variableOnly);

final calendarMonthRangeProvider = Provider<DateRange>((ref) {
  final month = ref.watch(calendarFocusedMonthProvider);
  return monthRange(month.year, month.month);
});

final calendarMonthExpensesProvider = Provider<List<Expense>>((ref) {
  final all = ref.watch(expenseProvider);
  final range = ref.watch(calendarMonthRangeProvider);
  final filter = ref.watch(calendarExpenseFilterProvider);
  return all.where((e) {
    if (!range.contains(e.date)) return false;
    if (filter == ExpenseFilter.variableOnly && e.isFixed) return false;
    return true;
  }).toList();
});

/// 이번 달 총 지출(필터 반영).
final calendarMonthTotalProvider = Provider<double>((ref) {
  final expenses = ref.watch(calendarMonthExpensesProvider);
  return expenses.fold(0.0, (sum, e) => sum + e.amount);
});

/// 날짜(시각 제외)별 지출 합계 — 캘린더 셀에 표시.
final calendarDailyTotalsProvider = Provider<Map<DateTime, double>>((ref) {
  final expenses = ref.watch(calendarMonthExpensesProvider);
  final totals = <DateTime, double>{};
  for (final e in expenses) {
    final day = dateOnly(e.date);
    totals.update(day, (v) => v + e.amount, ifAbsent: () => e.amount);
  }
  return totals;
});

/// 선택된 날짜의 지출 내역(최신순).
final calendarSelectedDayExpensesProvider = Provider<List<Expense>>((ref) {
  final expenses = ref.watch(calendarMonthExpensesProvider);
  final selected = ref.watch(calendarSelectedDayProvider);
  return expenses.where((e) => dateOnly(e.date) == selected).toList()
    ..sort((a, b) => b.date.compareTo(a.date));
});
