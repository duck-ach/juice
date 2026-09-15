import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';
import '../data/local/prefs_service.dart';
import '../data/models/budget_period.dart';
import '../data/models/expense.dart';
import '../providers/budget_settings_provider.dart';
import '../providers/currency_provider.dart';
import '../providers/expense_provider.dart';
import 'exchange_rate_service.dart';

/// 기준 통화를 바꿀 때, 이미 기록된 지출/수입과 주기별 목표 예산을 새 기준 통화로
/// 일괄 환산한다(오늘 날짜 최신 환율 기준).
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
      return (
        currency: existing['currency'] as String,
        amount: (existing['amount'] as num).toDouble(),
      );
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
        final anchor = _anchorFor(anchors, 'expense_${expense.id}',
            currentCurrency: fromCode, currentAmount: expense.amount);
        final rate = await rateFromAnchor(anchor.currency);
        if (rate != null) {
          expense.amount = _round(anchor.amount * rate, toCurrency);
        } else if (baseRate != null) {
          expense.amount = _round(expense.amount * baseRate, toCurrency);
        } else {
          allConverted = false;
          continue;
        }
        await expense.save();
      }
    }
    ref.invalidate(expenseProvider);

    final amounts = ref.read(periodTargetAmountsProvider);
    final notifier = ref.read(periodTargetAmountsProvider.notifier);
    for (final period in BudgetPeriod.values) {
      final current = amounts.forPeriod(period);
      if (current == null) continue;
      final anchor = _anchorFor(anchors, _budgetAnchorKeys[period]!,
          currentCurrency: fromCode, currentAmount: current);
      final rate = await rateFromAnchor(anchor.currency);
      if (rate != null) {
        await notifier.setForPeriod(period, _round(anchor.amount * rate, toCurrency));
      } else if (baseRate != null) {
        await notifier.setForPeriod(period, _round(current * baseRate, toCurrency));
      } else {
        allConverted = false;
      }
    }

    await _saveAnchors(anchors);
    return allConverted;
  }
}
