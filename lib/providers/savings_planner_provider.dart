import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';
import 'juice_saving_provider.dart';

const _savingsPlanKey = 'savingsPlan';

/// 플래너 수입 입력 단계에서 고르는 소득 형태. 계산식에는 영향을 주지 않고,
/// 불규칙 소득자에게는 "최소 안전 수입"을 적으라는 안내 문구를 다르게 보여주는 데만 쓰인다.
enum IncomeType { fixed, irregular, allowance }

class FixedExpenseItem {
  const FixedExpenseItem({required this.name, required this.amount});

  final String name;
  final double amount;

  Map<String, dynamic> toJson() => {'name': name, 'amount': amount};

  factory FixedExpenseItem.fromJson(Map<String, dynamic> json) =>
      FixedExpenseItem(
        name: json['name'] as String? ?? '',
        amount: (json['amount'] as num?)?.toDouble() ?? 0,
      );
}

const defaultFixedExpenseNames = ['월세', '통신비', '보험료', '구독료'];

/// 중/장기 저축 목표 플래너 입력값. 월 수입/고정지출/목표를 바탕으로
/// "스마트 주스 용량"(월·주·일 변동지출 예산)을 계산하는 데 쓰인다.
class SavingsPlan {
  const SavingsPlan({
    this.enabled = false,
    this.monthlyIncome,
    this.incomeType = IncomeType.fixed,
    this.goalYears = 0,
    this.goalMonths = 0,
    this.goalAmount,
    this.fixedExpenses = const [],
    this.createdAt,
  });

  final bool enabled;
  final double? monthlyIncome;
  final IncomeType incomeType;
  final int goalYears;
  final int goalMonths;
  final double? goalAmount;
  final List<FixedExpenseItem> fixedExpenses;

  /// 플랜이 (재)시작된 시각 — 재조정(recalibration)은 이 값을 보존하지만, 위저드로
  /// 플랜을 통째로 다시 짜면 갱신된다. 저축 페이스 계산의 기준선이며, 이 값이 없으면
  /// (과거에 저장된 플랜 등) 페이스는 계산하지 않는다.
  final DateTime? createdAt;

  SavingsPlan copyWith({
    bool? enabled,
    double? monthlyIncome,
    IncomeType? incomeType,
    int? goalYears,
    int? goalMonths,
    double? goalAmount,
    List<FixedExpenseItem>? fixedExpenses,
    DateTime? createdAt,
  }) =>
      SavingsPlan(
        enabled: enabled ?? this.enabled,
        monthlyIncome: monthlyIncome ?? this.monthlyIncome,
        incomeType: incomeType ?? this.incomeType,
        goalYears: goalYears ?? this.goalYears,
        goalMonths: goalMonths ?? this.goalMonths,
        goalAmount: goalAmount ?? this.goalAmount,
        fixedExpenses: fixedExpenses ?? this.fixedExpenses,
        createdAt: createdAt ?? this.createdAt,
      );

  int get totalMonths => goalYears * 12 + goalMonths;

  /// 위저드를 끝까지 완료해 실제로 계산 가능한 상태인지.
  bool get isComplete =>
      (monthlyIncome ?? 0) > 0 && (goalAmount ?? 0) > 0 && totalMonths > 0;

  double get fixedExpenseTotal =>
      fixedExpenses.fold(0.0, (sum, e) => sum + e.amount);

  /// 월 가용 생활비(= 스마트 주스 용량) = 월 수입 - 고정지출 합계 - (목표 금액 / 총 개월 수).
  /// 입력이 아직 부족하면 null.
  double? get monthlyAvailable {
    if (monthlyIncome == null || goalAmount == null || totalMonths <= 0) {
      return null;
    }
    final monthlySavingNeeded = goalAmount! / totalMonths;
    return monthlyIncome! - fixedExpenseTotal - monthlySavingNeeded;
  }

  double? get dailyAvailable =>
      monthlyAvailable == null ? null : monthlyAvailable! / 30;

  double? get weeklyAvailable =>
      dailyAvailable == null ? null : dailyAvailable! * 7;

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'monthlyIncome': monthlyIncome,
        'incomeType': incomeType.name,
        'goalYears': goalYears,
        'goalMonths': goalMonths,
        'goalAmount': goalAmount,
        'fixedExpenses': fixedExpenses.map((e) => e.toJson()).toList(),
        'createdAt': createdAt?.toIso8601String(),
      };

  factory SavingsPlan.fromJson(Map<String, dynamic> json) => SavingsPlan(
        enabled: json['enabled'] as bool? ?? false,
        monthlyIncome: (json['monthlyIncome'] as num?)?.toDouble(),
        incomeType: IncomeType.values.firstWhere(
            (t) => t.name == json['incomeType'],
            orElse: () => IncomeType.fixed),
        goalYears: json['goalYears'] as int? ?? 0,
        goalMonths: json['goalMonths'] as int? ?? 0,
        goalAmount: (json['goalAmount'] as num?)?.toDouble(),
        fixedExpenses: (json['fixedExpenses'] as List<dynamic>? ?? [])
            .map((e) =>
                FixedExpenseItem.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList(),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.tryParse(json['createdAt'] as String),
      );

  static List<FixedExpenseItem> get defaultFixedExpenses =>
      defaultFixedExpenseNames
          .map((n) => FixedExpenseItem(name: n, amount: 0))
          .toList();
}

/// 연봉 인상·이직 등으로 수입이 바뀌었을 때, 목표(goalAmount)와 고정지출은 그대로 둔 채
/// 수입 값만 갱신하는 두 가지 재조정 방식.
extension SavingsPlanRecalibration on SavingsPlan {
  /// 방식 1) 생활비(주스)는 지금 수준으로 유지하고, 늘어난 여유만큼 목표 기간을 앞당긴다.
  /// 새 월 저축여력이 0 이하(수입이 고정비+기존 생활비도 못 채움)면 재조정할 수 없으므로
  /// 원래 플랜을 그대로 반환한다 — 호출 측이 totalMonths가 줄지 않았는지로 가드해야 한다.
  SavingsPlan recalibrateShortenDuration(double newIncome) {
    final currentMonthlyAvailable = monthlyAvailable;
    if (currentMonthlyAvailable == null || goalAmount == null) return this;
    final newMonthlySaving =
        newIncome - fixedExpenseTotal - currentMonthlyAvailable;
    if (newMonthlySaving <= 0) return this;
    final newTotalMonths = (goalAmount! / newMonthlySaving).ceil();
    return copyWith(
      monthlyIncome: newIncome,
      goalYears: newTotalMonths ~/ 12,
      goalMonths: newTotalMonths % 12,
    );
  }

  /// 방식 2) 목표 기간은 그대로 두고, 새 수입 기준으로 생활비(주스) 용량만 다시 계산한다.
  SavingsPlan recalibrateIncreaseBudget(double newIncome) =>
      copyWith(monthlyIncome: newIncome);
}

/// [createdAt] 시점 이후 실제 저축 페이스로 목표를 얼마나 앞당기고/늦추고 있는지 계산.
extension SavingsPlanPace on SavingsPlan {
  /// 플랜 시작 이후 경과 개월 수(최소 1 — 0으로 나누기 방지 및 첫 달 왜곡 방지).
  int elapsedMonths(DateTime now) {
    if (createdAt == null) return 0;
    final months =
        (now.year - createdAt!.year) * 12 + (now.month - createdAt!.month);
    return months < 1 ? 1 : months;
  }

  /// 지금까지의 누적 저축액([accumulatedSavings])이 그대로 이어진다고 가정했을 때
  /// 목표 금액을 채우는 데 걸릴 총 개월 수. 계산할 데이터가 부족하면 null.
  double? projectedTotalMonths(double accumulatedSavings, DateTime now) {
    if (createdAt == null || goalAmount == null || accumulatedSavings <= 0) {
      return null;
    }
    final monthlyPace = accumulatedSavings / elapsedMonths(now);
    if (monthlyPace <= 0) return null;
    return goalAmount! / monthlyPace;
  }

  /// 원래 계획(totalMonths) 대비 몇 개월 빠른지(+)/느린지(-). 데이터 부족 시 null.
  int? paceDeltaMonths(double accumulatedSavings, DateTime now) {
    final projected = projectedTotalMonths(accumulatedSavings, now);
    if (projected == null) return null;
    return (totalMonths - projected).round();
  }
}

class SavingsPlanNotifier extends Notifier<SavingsPlan> {
  @override
  SavingsPlan build() {
    final raw = Hive.box(HiveBoxes.settings).get(_savingsPlanKey) as String?;
    if (raw == null) {
      return SavingsPlan(fixedExpenses: SavingsPlan.defaultFixedExpenses);
    }
    try {
      return SavingsPlan.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return SavingsPlan(fixedExpenses: SavingsPlan.defaultFixedExpenses);
    }
  }

  Future<void> update(SavingsPlan plan) async {
    await Hive.box(HiveBoxes.settings)
        .put(_savingsPlanKey, jsonEncode(plan.toJson()));
    state = plan;
  }
}

final savingsPlanProvider =
    NotifierProvider<SavingsPlanNotifier, SavingsPlan>(SavingsPlanNotifier.new);

/// 활성화된 완성 플랜이 있을 때만 값을 반환하는 저축 페이스 델타(개월). 그 외엔 null —
/// UI는 null이면 페이스 문구 자체를 숨긴다.
final savingsPlanPaceProvider = Provider<int?>((ref) {
  final plan = ref.watch(savingsPlanProvider);
  if (!plan.enabled || !plan.isComplete) return null;
  final accumulated = ref.watch(totalAccumulatedSavingsProvider);
  return plan.paceDeltaMonths(accumulated, DateTime.now());
});
