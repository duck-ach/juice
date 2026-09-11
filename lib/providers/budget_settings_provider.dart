import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';
import '../data/models/budget_period.dart';
import '../data/models/week_start_day.dart';

const _budgetPeriodKey = 'budgetPeriod';
const _legacyTargetAmountKey = 'targetAmount';
const _targetAmountDailyKey = 'targetAmountDaily';
const _targetAmountWeeklyKey = 'targetAmountWeekly';
const _targetAmountMonthlyKey = 'targetAmountMonthly';
const _weekStartDayKey = 'weekStartDay';

/// 목표(주스) 추적 주기. 기본값은 주간.
class BudgetPeriodNotifier extends Notifier<BudgetPeriod> {
  @override
  BudgetPeriod build() {
    final stored =
        Hive.box(HiveBoxes.settings).get(_budgetPeriodKey) as String?;
    return BudgetPeriod.values.firstWhere(
      (p) => p.name == stored,
      orElse: () => BudgetPeriod.weekly,
    );
  }

  Future<void> setPeriod(BudgetPeriod period) async {
    await Hive.box(HiveBoxes.settings).put(_budgetPeriodKey, period.name);
    state = period;
  }
}

final budgetPeriodProvider =
    NotifierProvider<BudgetPeriodNotifier, BudgetPeriod>(
        BudgetPeriodNotifier.new);

/// 일간/주간/월간 목표 금액(mL)을 각각 독립적으로 보관.
class PeriodTargetAmounts {
  const PeriodTargetAmounts({this.daily, this.weekly, this.monthly});

  final double? daily;
  final double? weekly;
  final double? monthly;

  /// 온보딩을 한 번이라도 완료했는지(주기 중 하나라도 설정된 적 있는지) 여부.
  bool get hasAny => daily != null || weekly != null || monthly != null;

  double? forPeriod(BudgetPeriod period) => switch (period) {
        BudgetPeriod.daily => daily,
        BudgetPeriod.weekly => weekly,
        BudgetPeriod.monthly => monthly,
      };

  PeriodTargetAmounts copyWith(
          {double? daily, double? weekly, double? monthly}) =>
      PeriodTargetAmounts(
        daily: daily ?? this.daily,
        weekly: weekly ?? this.weekly,
        monthly: monthly ?? this.monthly,
      );
}

/// 각 주기별 목표 금액. 과거 단일 targetAmount만 쓰던 기기는 세 값 모두 그 값으로 이전(migration)한다.
class PeriodTargetAmountsNotifier extends Notifier<PeriodTargetAmounts> {
  @override
  PeriodTargetAmounts build() {
    final box = Hive.box(HiveBoxes.settings);
    final legacy = box.get(_legacyTargetAmountKey);
    final legacyValue = legacy is num ? legacy.toDouble() : null;

    double? read(String key) {
      final stored = box.get(key);
      return stored is num ? stored.toDouble() : legacyValue;
    }

    return PeriodTargetAmounts(
      daily: read(_targetAmountDailyKey),
      weekly: read(_targetAmountWeeklyKey),
      monthly: read(_targetAmountMonthlyKey),
    );
  }

  Future<void> setForPeriod(BudgetPeriod period, double amount) async {
    final box = Hive.box(HiveBoxes.settings);
    final key = switch (period) {
      BudgetPeriod.daily => _targetAmountDailyKey,
      BudgetPeriod.weekly => _targetAmountWeeklyKey,
      BudgetPeriod.monthly => _targetAmountMonthlyKey,
    };
    await box.put(key, amount);
    state = switch (period) {
      BudgetPeriod.daily => state.copyWith(daily: amount),
      BudgetPeriod.weekly => state.copyWith(weekly: amount),
      BudgetPeriod.monthly => state.copyWith(monthly: amount),
    };
  }

  /// 저축 플래너의 자동 세팅 — 세 주기 모두 한 번에 저장한다.
  Future<void> setAll(
      {required double daily,
      required double weekly,
      required double monthly}) async {
    final box = Hive.box(HiveBoxes.settings);
    await box.put(_targetAmountDailyKey, daily);
    await box.put(_targetAmountWeeklyKey, weekly);
    await box.put(_targetAmountMonthlyKey, monthly);
    state = PeriodTargetAmounts(daily: daily, weekly: weekly, monthly: monthly);
  }
}

final periodTargetAmountsProvider =
    NotifierProvider<PeriodTargetAmountsNotifier, PeriodTargetAmounts>(
        PeriodTargetAmountsNotifier.new);

/// 현재 활성 주기(budgetPeriodProvider)에 해당하는 목표 금액. null이면 해당 주기 목표 미설정.
final targetAmountProvider = Provider<double?>((ref) {
  final period = ref.watch(budgetPeriodProvider);
  final amounts = ref.watch(periodTargetAmountsProvider);
  return amounts.forPeriod(period);
});

/// 일주일의 시작 요일. 기본값은 월요일.
class WeekStartDayNotifier extends Notifier<WeekStartDay> {
  @override
  WeekStartDay build() {
    final stored =
        Hive.box(HiveBoxes.settings).get(_weekStartDayKey) as String?;
    return WeekStartDay.values.firstWhere(
      (d) => d.name == stored,
      orElse: () => WeekStartDay.monday,
    );
  }

  Future<void> setDay(WeekStartDay day) async {
    await Hive.box(HiveBoxes.settings).put(_weekStartDayKey, day.name);
    state = day;
  }
}

final weekStartDayProvider =
    NotifierProvider<WeekStartDayNotifier, WeekStartDay>(
        WeekStartDayNotifier.new);
