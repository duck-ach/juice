import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';
import '../data/local/prefs_service.dart';
import '../data/models/budget_period.dart';
import '../data/models/expense.dart';
import '../providers/budget_settings_provider.dart';
import '../providers/currency_provider.dart';
import '../data/models/juice_saving_history.dart';
import '../providers/expense_provider.dart';
import '../providers/juice_saving_provider.dart';
import '../providers/savings_planner_provider.dart';
import 'exchange_rate_service.dart';

/// 기준 통화를 바꿀 때, 이미 기록된 지출/수입, 주기별 목표 예산, 중/장기 저축 플랜,
/// 마감된 주기 기록의 목표량을 새 기준 통화로 일괄 환산한다(오늘 날짜 최신 환율 기준).
///
/// 외화(originalCurrency)로 기록된 지출은 [Expense.originalAmount]라는 불변의 원본이
/// 이미 있어 항상 그 값을 기준으로 재환산하므로 여러 번 통화를 바꿔도 오차가 누적되지
/// 않는다. 반면 기준 통화로 그대로 기록된 일반 거래/예산 목표는 원본을 보관하는 필드가
/// 없어, 매번 "직전 마이그레이션 결과 금액"에 새 환율을 곱하면 통화를 여러 번 바꿀 때마다
/// 반올림 오차가 누적된다. 이를 막기 위해 [_loadAnchors]가 반환하는 맵에 "이 거래/예산이
/// 처음 마이그레이션을 겪기 직전의 진짜 원본 금액+통화"를 한 번만 기록해두고, 이후의
/// 모든 마이그레이션은 항상 이 원본 스냅샷에서 다시 환산한다.
class CurrencyMigrationService {
  CurrencyMigrationService._();

  static const _anchorsPrefsKey = 'currencyMigrationAnchors';
  static const _budgetAnchorKeys = {
    BudgetPeriod.daily: 'budget_daily',
    BudgetPeriod.weekly: 'budget_weekly',
    BudgetPeriod.monthly: 'budget_monthly',
  };

  static double _round(double amount, CurrencyItem currency) =>
      currency.decimalDigits > 0
          ? double.parse(amount.toStringAsFixed(currency.decimalDigits))
          : amount.roundToDouble();

  static Map<String, dynamic> _loadAnchors() {
    final raw = PrefsService.prefs.getString(_anchorsPrefsKey);
    if (raw == null) return {};
    try {
      return json.decode(raw) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  static Future<void> _saveAnchors(Map<String, dynamic> anchors) =>
      PrefsService.prefs.setString(_anchorsPrefsKey, json.encode(anchors));

  /// [key]에 저장된 원본(통화, 금액)이 없으면 지금의 [currentCurrency]/[currentAmount]를
  /// 원본으로 새로 등록하고, 이미 있으면 그 원본을 그대로 반환한다(이후 마이그레이션은
  /// 항상 이 값을 기준으로 재환산되어 오차가 누적되지 않는다).
  static ({String currency, double amount}) _anchorFor(
    Map<String, dynamic> anchors,
    String key, {
    required String currentCurrency,
    required double currentAmount,
  }) {
    final existing = anchors[key] as Map<String, dynamic>?;
    if (existing != null) {
      // 마지막 환산 결과('result')가 지금 값과 다르면, 그 사이 사용자가 직접 값을 고친 것이므로
      // 옛 원본 앵커는 더 이상 유효하지 않다 — 지금 값을 새 원본으로 삼는다.
      final lastResult = (existing['result'] as num?)?.toDouble();
      final stale =
          lastResult != null && (lastResult - currentAmount).abs() > 0.01;
      if (!stale) {
        return (
          currency: existing['currency'] as String,
          amount: (existing['amount'] as num).toDouble(),
        );
      }
    }
    anchors[key] = {'currency': currentCurrency, 'amount': currentAmount};
    return (currency: currentCurrency, amount: currentAmount);
  }

  /// 반환값은 이번 마이그레이션으로 관련된 모든 지출/예산이 실제로 환산됐는지 여부.
  /// false면(오프라인 등으로 일부 통화쌍의 환율을 못 가져온 경우) 일부 금액이 이전 통화
  /// 그대로 남아있다는 뜻이므로, 호출부는 이 값이 true일 때만 기준 통화 전환을 확정해야
  /// 한다 — 그렇지 않으면 금액은 안 바뀌었는데 통화 기호만 바뀌어 표시값이 왜곡된다.
  static Future<bool> migrateBaseCurrency(
    WidgetRef ref, {
    required String fromCode,
    required String toCode,
  }) async {
    if (fromCode == toCode) return true;

    final toCurrency = currencyByCode(toCode);
    final today = DateTime.now();
    final baseRate = await ExchangeRateService.fetchRate(
        from: fromCode, to: toCode, date: today);

    final anchors = _loadAnchors();
    final anchorRateCache = <String, double?>{};

    // 원본 통화 -> 새 기준 통화 환율. 원본이 직전 기준 통화(fromCode)와 같으면 이미
    // 조회한 baseRate를 재사용해 중복 네트워크 호출을 피한다.
    Future<double?> rateFromAnchor(String anchorCurrency) async {
      if (anchorCurrency == toCode) return 1.0;
      if (anchorCurrency == fromCode) return baseRate;
      if (anchorRateCache.containsKey(anchorCurrency)) {
        return anchorRateCache[anchorCurrency];
      }
      final rate = await ExchangeRateService.fetchRate(
          from: anchorCurrency, to: toCode, date: today);
      anchorRateCache[anchorCurrency] = rate;
      return rate;
    }

    var allConverted = true;

    /// [key]의 최초 원본 앵커에서 새 기준 통화로 다시 환산한 값. 환율을 못 구하면 null.
    Future<double?> convertAnchored(String key, double current) async {
      final anchor = _anchorFor(anchors, key,
          currentCurrency: fromCode, currentAmount: current);
      final rate = await rateFromAnchor(anchor.currency);
      double? result;
      if (rate != null) {
        result = _round(anchor.amount * rate, toCurrency);
      } else if (baseRate != null) {
        result = _round(current * baseRate, toCurrency);
      }
      if (result != null) {
        (anchors[key] as Map<String, dynamic>)['result'] = result;
      }
      return result;
    }

    final box = Hive.box<Expense>(HiveBoxes.expenses);
    for (final expense in box.values.toList()) {
      final originalCurrency = expense.originalCurrency;
      if (originalCurrency != null) {
        if (originalCurrency == toCode) {
          expense.amount = expense.originalAmount!;
          expense.exchangeRate = 1.0;
        } else {
          final rate = await ExchangeRateService.fetchRate(
              from: originalCurrency, to: toCode, date: today);
          if (rate != null) {
            expense.amount =
                _round(expense.originalAmount! * rate, toCurrency);
            expense.exchangeRate = rate;
          } else if (baseRate != null) {
            expense.amount = _round(expense.amount * baseRate, toCurrency);
          } else {
            allConverted = false;
            continue;
          }
        }
        await expense.save();
      } else {
        final converted =
            await convertAnchored('expense_${expense.id}', expense.amount);
        if (converted == null) {
          allConverted = false;
          continue;
        }
        expense.amount = converted;
        await expense.save();
      }
    }
    ref.invalidate(expenseProvider);

    final amounts = ref.read(periodTargetAmountsProvider);
    final notifier = ref.read(periodTargetAmountsProvider.notifier);
    for (final period in BudgetPeriod.values) {
      final current = amounts.forPeriod(period);
      if (current == null) continue;
      final converted =
          await convertAnchored(_budgetAnchorKeys[period]!, current);
      if (converted == null) {
        allConverted = false;
      } else {
        await notifier.setForPeriod(period, converted);
      }
    }

    // 중/장기 저축 플랜(월 수입·목표 금액·고정지출·고정수입)도 같은 기준 통화 금액이라 함께 환산한다.
    final plan = ref.read(savingsPlanProvider);
    if (plan.monthlyIncome != null ||
        plan.goalAmount != null ||
        plan.weeklyLivingExpense != null ||
        plan.fixedExpenses.isNotEmpty ||
        plan.fixedIncomes.isNotEmpty) {
      Future<double?> nullable(String key, double? value) async {
        if (value == null) return null;
        final converted = await convertAnchored(key, value);
        if (converted == null) allConverted = false;
        return converted ?? value;
      }

      final monthlyIncome = await nullable('plan_monthlyIncome', plan.monthlyIncome);
      final weeklyLiving =
          await nullable('plan_weeklyLiving', plan.weeklyLivingExpense);
      final goalAmount = await nullable('plan_goalAmount', plan.goalAmount);
      final fixedExpenses = <FixedExpenseItem>[];
      for (var i = 0; i < plan.fixedExpenses.length; i++) {
        final item = plan.fixedExpenses[i];
        final converted = await nullable('plan_fixedExpense_$i', item.amount);
        fixedExpenses.add(item.copyWith(amount: converted));
      }
      final fixedIncomes = <FixedIncomeItem>[];
      for (var i = 0; i < plan.fixedIncomes.length; i++) {
        final item = plan.fixedIncomes[i];
        final converted = await nullable('plan_fixedIncome_$i', item.amount);
        fixedIncomes.add(FixedIncomeItem(name: item.name, amount: converted!));
      }

      var migrated = SavingsPlan(
        enabled: plan.enabled,
        monthlyIncome: monthlyIncome,
        incomeType: plan.incomeType,
        incomeFrequency: plan.incomeFrequency,
        allowanceSubType: plan.allowanceSubType,
        weeklyLivingExpense: weeklyLiving,
        goalYears: plan.goalYears,
        goalMonths: plan.goalMonths,
        goalAmount: goalAmount,
        fixedExpenses: fixedExpenses,
        fixedIncomes: fixedIncomes,
        createdAt: plan.createdAt,
      );
      // 고정수입이 있으면 월 수입은 항상 그 합계여야 하므로, 항목별 반올림 오차가 생기지 않게 다시 합산한다.
      if (fixedIncomes.isNotEmpty) migrated = migrated.withFixedIncomes(fixedIncomes);
      await ref.read(savingsPlanProvider.notifier).update(migrated);
    }

    // 마감된 주기 기록의 목표량 스냅샷도 환산한다 — 안 하면 환산된 지출과 옛 통화의 목표를
    // 비교해 절약/초과 판정이 틀어진다.
    final historyBox = Hive.box<JuiceSavingHistory>(HiveBoxes.juiceSavingHistory);
    for (final history in historyBox.values.toList()) {
      final converted =
          await convertAnchored('history_${history.id}', history.targetAmount);
      if (converted == null) {
        allConverted = false;
        continue;
      }
      history.targetAmount = converted;
      await history.save();
    }
    ref.invalidate(juiceSavingHistoryProvider);

    await _saveAnchors(anchors);
    return allConverted;
  }
}
