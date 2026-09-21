import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';
import 'juice_saving_provider.dart';

const _savingsPlanKey = 'savingsPlan';

/// 플래너 수입 입력 단계에서 고르는 소득 형태. 유형에 따라 위저드의 질문/스텝 구성 자체가
/// 달라진다(고정 소득: 기존 플로우, 불규칙 소득: 최소 안전 수입 기반 역산, 용돈·시드머니:
/// 하위 [AllowanceSubType]로 다시 분기).
enum IncomeType { fixed, irregular, allowance }

/// 용돈·시드머니(allowance) 선택 시 추가로 고르는 하위 유형.
enum AllowanceSubType { regular, irregular }

/// 금액 입력의 지급 주기 — 표준 월 환산([monthlyEquivalent])에만 쓰이고, 저장되는
/// [SavingsPlan.monthlyIncome]은 항상 이미 월 환산된 값이다(위저드가 변환해 저장).
enum IncomeFrequency { monthly, biweekly, weekly }

extension IncomeFrequencyConvert on IncomeFrequency {
  /// 표준 월 환산: 매월=그대로, 2주마다=×26/12, 매주=×52/12.
  double monthlyEquivalent(double amount) => switch (this) {
        IncomeFrequency.monthly => amount,
        IncomeFrequency.biweekly => amount * 26 / 12,
        IncomeFrequency.weekly => amount * 52 / 12,
      };

  /// [monthlyEquivalent]의 역변환 — 저장된 월 환산액에서 위저드가 원래 입력창에
  /// 보여줄 "이 주기 기준" 원래 금액을 복원할 때 쓴다.
  double rawFromMonthly(double monthlyAmount) => switch (this) {
        IncomeFrequency.monthly => monthlyAmount,
        IncomeFrequency.biweekly => monthlyAmount * 12 / 26,
        IncomeFrequency.weekly => monthlyAmount * 12 / 52,
      };
}

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
    this.incomeFrequency = IncomeFrequency.monthly,
    this.allowanceSubType,
    this.weeklyLivingExpense,
    this.goalYears = 0,
    this.goalMonths = 0,
    this.goalAmount,
    this.fixedExpenses = const [],
    this.createdAt,
  });

  final bool enabled;

  /// 항상 월 환산된 값(표준 단위) — 위저드가 [incomeFrequency]로 입력받은 원 금액을
  /// 저장 시점에 이미 월 환산해 넣으므로, 이 필드를 쓰는 모든 계산(monthlyAvailable,
  /// 재조정, 자동 예산 적용 등)은 지급 주기를 몰라도 된다.
  final double? monthlyIncome;
  final IncomeType incomeType;

  /// [monthlyIncome] 입력 당시 사용자가 실제로 선택했던 지급 주기 스냅샷(재편집 시
  /// 위저드가 원래 선택을 복원하는 용도) — 계산에는 관여하지 않는다.
  final IncomeFrequency incomeFrequency;

  /// [IncomeType.allowance]일 때만 의미 있는 하위 유형.
  final AllowanceSubType? allowanceSubType;

  /// [IncomeType.irregular](불규칙 소득) 전용 — 주간 생활비(변동지출) 최소 예상액.
  final double? weeklyLivingExpense;

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
    IncomeFrequency? incomeFrequency,
    AllowanceSubType? allowanceSubType,
    double? weeklyLivingExpense,
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
        incomeFrequency: incomeFrequency ?? this.incomeFrequency,
        allowanceSubType: allowanceSubType ?? this.allowanceSubType,
        weeklyLivingExpense: weeklyLivingExpense ?? this.weeklyLivingExpense,
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

  /// [IncomeType.irregular](불규칙 소득) 전용 — 비수기 기준(최소 안전 수입) 연간 최소
  /// 저축 가능액 = (월 환산 최소 수입 − 고정비 − 주간 생활비×4.33) × 12. 음수면 0으로
  /// clamp(고정비+생활비가 최소 수입을 이미 초과하는 경우).
  double? get variableIncomeAnnualMinSavings {
    if (monthlyIncome == null || weeklyLivingExpense == null) return null;
    final monthly = monthlyIncome! - fixedExpenseTotal - weeklyLivingExpense! * 4.33;
    return (monthly * 12).clamp(0, double.infinity).toDouble();
  }

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'monthlyIncome': monthlyIncome,
        'incomeType': incomeType.name,
        'incomeFrequency': incomeFrequency.name,
        'allowanceSubType': allowanceSubType?.name,
        'weeklyLivingExpense': weeklyLivingExpense,
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
        incomeFrequency: IncomeFrequency.values.firstWhere(
            (f) => f.name == json['incomeFrequency'],
            orElse: () => IncomeFrequency.monthly),
        allowanceSubType: switch (json['allowanceSubType']) {
          'regular' => AllowanceSubType.regular,
          'irregular' => AllowanceSubType.irregular,
          _ => null,
        },
        weeklyLivingExpense: (json['weeklyLivingExpense'] as num?)?.toDouble(),
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
