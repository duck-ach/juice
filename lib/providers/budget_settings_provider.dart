import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';
import '../data/models/budget_period.dart';

const _budgetPeriodKey = 'budgetPeriod';
const _targetAmountKey = 'targetAmount';

/// 목표(주스) 추적 주기. 기본값은 주간.
class BudgetPeriodNotifier extends Notifier<BudgetPeriod> {
  @override
  BudgetPeriod build() {
    final stored = Hive.box(HiveBoxes.settings).get(_budgetPeriodKey) as String?;
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

final budgetPeriodProvider = NotifierProvider<BudgetPeriodNotifier, BudgetPeriod>(BudgetPeriodNotifier.new);

/// 목표 금액(mL). null이면 아직 온보딩을 완료하지 않은 상태.
class TargetAmountNotifier extends Notifier<double?> {
  @override
  double? build() {
    final stored = Hive.box(HiveBoxes.settings).get(_targetAmountKey);
    return stored is num ? stored.toDouble() : null;
  }

  Future<void> setTargetAmount(double amount) async {
    await Hive.box(HiveBoxes.settings).put(_targetAmountKey, amount);
    state = amount;
  }
}

final targetAmountProvider = NotifierProvider<TargetAmountNotifier, double?>(TargetAmountNotifier.new);
