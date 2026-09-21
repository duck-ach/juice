// SavingsPlan의 재조정(recalibration)과 저축 페이스 계산, 그리고 새 필드
// (incomeType/createdAt)를 포함한 JSON 직렬화 왕복 및 구버전 데이터 호환성을 검증한다.
import 'package:flutter_test/flutter_test.dart';
import 'package:juice/providers/savings_planner_provider.dart';

SavingsPlan _plan({
  double? monthlyIncome,
  int goalYears = 0,
  int goalMonths = 12,
  double? goalAmount = 12000000,
  List<FixedExpenseItem> fixedExpenses = const [],
  DateTime? createdAt,
}) =>
    SavingsPlan(
      enabled: true,
      monthlyIncome: monthlyIncome,
      goalYears: goalYears,
      goalMonths: goalMonths,
      goalAmount: goalAmount,
      fixedExpenses: fixedExpenses,
      createdAt: createdAt,
    );

void main() {
  group('recalibrateShortenDuration', () {
    test('생활비는 그대로 두고, 늘어난 수입만큼 목표 기간을 앞당긴다', () {
      // 월 100만원, 고정비 없음, 목표 1200만원/12개월 => 월 저축필요액 100만원,
      // 생활비 0원. 월 수입이 200만원으로 오르면 생활비 0원 유지 시 월 200만원을
      // 저축할 수 있으므로 1200만원 / 200만원 = 6개월로 단축돼야 함.
      final plan = _plan(monthlyIncome: 1000000, goalAmount: 12000000);
      final recalibrated = plan.recalibrateShortenDuration(2000000);
      expect(recalibrated.totalMonths, 6);
      expect(recalibrated.monthlyIncome, 2000000);
      // 생활비(주스)는 재조정 전과 동일하게 유지되어야 함.
      expect(recalibrated.monthlyAvailable, plan.monthlyAvailable);
    });

    test('새 수입으로 생활비를 유지할 수 없으면(저축여력이 0 이하) 원래 플랜을 그대로 반환', () {
      // 월 200만원, 고정비 50만원, 목표 1200만원/12개월 => 월 저축필요액 100만원,
      // 생활비(월가용) 50만원. 수입이 80만원으로 줄면 고정비 50만원 + 기존 생활비
      // 50만원도 못 채우므로(80만-50만-50만=-20만) 재조정 불가.
      final plan = _plan(
        monthlyIncome: 2000000,
        goalAmount: 12000000,
        fixedExpenses: const [FixedExpenseItem(name: '월세', amount: 500000)],
      );
      final recalibrated = plan.recalibrateShortenDuration(800000);
      expect(recalibrated.totalMonths, plan.totalMonths);
      expect(recalibrated.monthlyIncome, plan.monthlyIncome);
    });
  });

  group('recalibrateIncreaseBudget', () {
    test('목표 기간은 그대로 두고 수입만 갱신해 생활비가 재계산된다', () {
      final plan = _plan(monthlyIncome: 1000000, goalAmount: 12000000);
      final recalibrated = plan.recalibrateIncreaseBudget(2000000);
      expect(recalibrated.totalMonths, plan.totalMonths);
      expect(recalibrated.monthlyIncome, 2000000);
      // 월 저축필요액은 그대로 100만원이므로, 새 생활비는 200만원 - 100만원 = 100만원.
      expect(recalibrated.monthlyAvailable, 1000000);
    });
  });

  group('저축 페이스', () {
    test('createdAt이 없으면(과거 저장된 플랜) 계산하지 않고 null', () {
      final plan = _plan(monthlyIncome: 1000000, goalAmount: 12000000);
      expect(plan.paceDeltaMonths(500000, DateTime(2026, 6, 1)), isNull);
    });

    test('실제 페이스가 계획보다 빠르면 양수(+) 개월 수를 반환', () {
      // 목표 1200만원/12개월 = 월 100만원 필요. 시작 후 2개월 경과, 누적 300만원 =>
      // 실제 페이스 월 150만원 => 완주 예상 8개월 => 계획(12) - 예상(8) = +4개월 단축.
      final plan = _plan(
          monthlyIncome: 1500000,
          goalAmount: 12000000,
          createdAt: DateTime(2026, 1, 1));
      final delta = plan.paceDeltaMonths(3000000, DateTime(2026, 3, 1));
      expect(delta, 4);
    });

    test('실제 페이스가 계획보다 느리면 음수(-) 개월 수를 반환', () {
      // 2개월 경과, 누적 100만원 => 월 페이스 50만원 => 완주 예상 24개월 =>
      // 계획(12) - 예상(24) = -12개월(지연).
      final plan = _plan(
          monthlyIncome: 1000000,
          goalAmount: 12000000,
          createdAt: DateTime(2026, 1, 1));
      final delta = plan.paceDeltaMonths(1000000, DateTime(2026, 3, 1));
      expect(delta, -12);
    });

    test('누적 저축액이 0이면 계산할 데이터가 없으므로 null', () {
      final plan = _plan(
          monthlyIncome: 1000000,
          goalAmount: 12000000,
          createdAt: DateTime(2026, 1, 1));
      expect(plan.paceDeltaMonths(0, DateTime(2026, 3, 1)), isNull);
    });
  });

  group('IncomeFrequency 월 환산', () {
    test('매월은 그대로, 2주마다는 ×26/12, 매주는 ×52/12로 월 환산된다', () {
      expect(IncomeFrequency.monthly.monthlyEquivalent(3000000), 3000000);
      expect(IncomeFrequency.biweekly.monthlyEquivalent(1500000),
          closeTo(3250000, 0.01));
      expect(IncomeFrequency.weekly.monthlyEquivalent(750000),
          closeTo(3250000, 0.01));
    });

    test('rawFromMonthly는 monthlyEquivalent의 역변환이다', () {
      const freq = IncomeFrequency.biweekly;
      const raw = 1500000.0;
      final monthly = freq.monthlyEquivalent(raw);
      expect(freq.rawFromMonthly(monthly), closeTo(raw, 0.01));
    });
  });

  group('불규칙 소득(Type B) 연간 최소 저축 가능액', () {
    test('(월 환산 최소 수입 − 고정비 − 주간 생활비×4.33) × 12', () {
      // 최소 수입 300만, 고정비 50만, 주간 생활비 10만
      // => (300만 - 50만 - 10만*4.33) * 12 = (300만-50만-43.3만)*12 = 206.7만*12 = 2480.4만
      final plan = SavingsPlan(
        monthlyIncome: 3000000,
        incomeType: IncomeType.irregular,
        weeklyLivingExpense: 100000,
        fixedExpenses: const [FixedExpenseItem(name: '월세', amount: 500000)],
      );
      expect(plan.variableIncomeAnnualMinSavings, closeTo(24804000, 1));
    });

    test('고정비+생활비가 최소 수입을 초과하면 0으로 clamp', () {
      final plan = SavingsPlan(
        monthlyIncome: 1000000,
        incomeType: IncomeType.irregular,
        weeklyLivingExpense: 300000,
        fixedExpenses: const [FixedExpenseItem(name: '월세', amount: 500000)],
      );
      expect(plan.variableIncomeAnnualMinSavings, 0);
    });

    test('weeklyLivingExpense가 없으면 계산할 수 없어 null', () {
      final plan = SavingsPlan(monthlyIncome: 3000000, incomeType: IncomeType.irregular);
      expect(plan.variableIncomeAnnualMinSavings, isNull);
    });
  });

  group('JSON 직렬화', () {
    test('incomeType/createdAt을 포함해 왕복 직렬화된다', () {
      final plan = SavingsPlan(
        enabled: true,
        monthlyIncome: 3000000,
        incomeType: IncomeType.irregular,
        goalYears: 1,
        goalMonths: 6,
        goalAmount: 20000000,
        fixedExpenses: const [FixedExpenseItem(name: '월세', amount: 500000)],
        createdAt: DateTime(2026, 3, 14, 9, 30),
      );
      final restored = SavingsPlan.fromJson(plan.toJson());
      expect(restored.incomeType, IncomeType.irregular);
      expect(restored.createdAt, DateTime(2026, 3, 14, 9, 30));
      expect(restored.monthlyIncome, 3000000);
      expect(restored.fixedExpenses.single.name, '월세');
    });

    test('incomeFrequency/allowanceSubType/weeklyLivingExpense도 왕복 직렬화된다', () {
      final plan = SavingsPlan(
        enabled: true,
        monthlyIncome: 500000,
        incomeType: IncomeType.allowance,
        incomeFrequency: IncomeFrequency.weekly,
        allowanceSubType: AllowanceSubType.irregular,
        weeklyLivingExpense: 80000,
        goalYears: 1,
        goalAmount: 6000000,
      );
      final restored = SavingsPlan.fromJson(plan.toJson());
      expect(restored.incomeFrequency, IncomeFrequency.weekly);
      expect(restored.allowanceSubType, AllowanceSubType.irregular);
      expect(restored.weeklyLivingExpense, 80000);
    });

    test('구버전 데이터(incomeType/createdAt 키 없음)를 불러오면 안전한 기본값으로 대체', () {
      final legacyJson = {
        'enabled': true,
        'monthlyIncome': 2500000.0,
        'goalYears': 1,
        'goalMonths': 0,
        'goalAmount': 10000000.0,
        'fixedExpenses': <Map<String, dynamic>>[],
      };
      final restored = SavingsPlan.fromJson(legacyJson);
      expect(restored.incomeType, IncomeType.fixed);
      expect(restored.createdAt, isNull);
      expect(restored.monthlyIncome, 2500000.0);
    });
  });
}
