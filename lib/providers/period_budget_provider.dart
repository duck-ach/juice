import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/week_utils.dart';
import '../data/models/expense.dart';
import 'budget_settings_provider.dart';
import 'expense_provider.dart';

/// 선택된 목표 주기(일/주/월)에 해당하는 현재 날짜 범위.
final currentBudgetRangeProvider = Provider<DateRange>((ref) {
  final period = ref.watch(budgetPeriodProvider);
  final weekStartDay = ref.watch(weekStartDayProvider);
  return rangeForPeriod(period, null, weekStartDay);
});

/// 홈 화면은 순수 지출만 추적 — 수입 기록은 게이지/목록에서 항상 제외.
final periodExpensesProvider = Provider<List<Expense>>((ref) {
  final all = ref.watch(expenseProvider);
  final range = ref.watch(currentBudgetRangeProvider);
  return all.where((e) => !e.isIncome && range.contains(e.date)).toList()
    ..sort((a, b) => b.date.compareTo(a.date));
});

final filteredPeriodExpensesProvider = Provider<List<Expense>>((ref) {
  final expenses = ref.watch(periodExpensesProvider);
  final filter = ref.watch(expenseFilterProvider);
  if (filter == ExpenseFilter.all) return expenses;
  return expenses.where((e) => !e.isFixed).toList();
});

/// 현재 주기 내 변동지출 합계(고정지출 제외) — 주스 게이지가 참조하는 값.
final periodSpentProvider = Provider<double>((ref) {
  final expenses = ref.watch(periodExpensesProvider);
  return expenses
      .where((e) => !e.isFixed)
      .fold(0.0, (sum, e) => sum + e.amount);
});

/// 남은 목표 비율(0.0~1.0) — 주스 게이지 수위/색상에 사용.
final periodRemainingRatioProvider = Provider<double>((ref) {
  final target = ref.watch(targetAmountProvider);
  if (target == null || target <= 0) return 0;
  final spent = ref.watch(periodSpentProvider);
  final remaining = target - spent;
  return (remaining / target).clamp(0.0, 1.0);
});
