import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/week_utils.dart';
import '../data/models/expense.dart';
import 'budget_settings_provider.dart';
import 'expense_provider.dart';
import 'juice_saving_provider.dart';
import 'saving_option_provider.dart';

/// 선택된 목표 주기(일/주/월)에 해당하는 현재 날짜 범위.
final currentBudgetRangeProvider = Provider<DateRange>((ref) {
  final period = ref.watch(budgetPeriodProvider);
  final weekStartDay = ref.watch(weekStartDayProvider);
  return rangeForPeriod(period, null, weekStartDay);
});

/// [SavingOption.rollover]가 선택돼 있고 바로 직전 같은 유형 주기가 남은 주스(양수)로
/// 마감됐다면 그 이월량을, 아니면(저축 옵션이거나 이월할 대상이 없음) 0을 반환한다.
final rolloverBonusProvider = Provider<double>((ref) {
  if (ref.watch(savingOptionProvider) != SavingOption.rollover) return 0;

  final period = ref.watch(budgetPeriodProvider);
  final weekStartDay = ref.watch(weekStartDayProvider);
  final currentRange = ref.watch(currentBudgetRangeProvider);
  final previousRange = previousPeriodRange(period, currentRange, weekStartDay);

  final records = ref.watch(juiceSavingRecordsProvider);
  for (final r in records) {
    if (r.history.periodTypeEnum == period &&
        r.history.startDate == previousRange.start) {
      return r.saved > 0 ? r.saved : 0;
    }
  }
  return 0;
});

/// 이번 주기 실제 목표량 = 설정된 기본 목표량 + [rolloverBonusProvider].
final effectiveTargetAmountProvider = Provider<double?>((ref) {
  final baseTarget = ref.watch(targetAmountProvider);
  if (baseTarget == null) return null;
  return baseTarget + ref.watch(rolloverBonusProvider);
});

/// 홈 화면은 순수 지출만 추적 — 수입 기록과 저축/투자(통장 이동) 기록은 게이지/목록에서
/// 항상 제외.
final periodExpensesProvider = Provider<List<Expense>>((ref) {
  final all = ref.watch(expenseProvider);
  final range = ref.watch(currentBudgetRangeProvider);
  return all
      .where((e) => !e.isIncome && !e.isSavings && range.contains(e.date))
      .toList()
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
  final target = ref.watch(effectiveTargetAmountProvider);
  if (target == null || target <= 0) return 0;
  final spent = ref.watch(periodSpentProvider);
  final remaining = target - spent;
  return (remaining / target).clamp(0.0, 1.0);
});
