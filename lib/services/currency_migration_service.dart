import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';
import '../data/models/budget_period.dart';
import '../data/models/expense.dart';
import '../providers/budget_settings_provider.dart';
import '../providers/currency_provider.dart';
import '../providers/expense_provider.dart';
import 'exchange_rate_service.dart';

/// 기준 통화를 바꿀 때, 이미 기록된 지출/수입 금액과 주기별 목표 예산을 새 기준 통화로
/// 일괄 환산한다(오늘 날짜 최신 환율 기준). 외화(originalCurrency)로 기록된 지출은
/// 그 원본 통화 기준으로 각각 다시 정확히 환산하고, 원본 통화가 새 기준 통화와 같아지면
/// amount를 원본 금액 그대로 복원한다.
class CurrencyMigrationService {
  CurrencyMigrationService._();

  static double _round(double amount, CurrencyItem currency) =>
      currency.decimalDigits > 0
          ? double.parse(amount.toStringAsFixed(currency.decimalDigits))
          : amount.roundToDouble();

  /// 반환값은 [fromCode] -> [toCode] 환율 조회 성공 여부. false면(오프라인 등) 외화
  /// 원본이 있는 지출만 환산되고, 일반 지출/수입/예산은 이전 금액 그대로 유지된다.
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
          }
        }
        await expense.save();
      } else if (baseRate != null) {
        expense.amount = _round(expense.amount * baseRate, toCurrency);
        await expense.save();
      }
    }
    ref.invalidate(expenseProvider);

    if (baseRate != null) {
      final amounts = ref.read(periodTargetAmountsProvider);
      final notifier = ref.read(periodTargetAmountsProvider.notifier);
      if (amounts.daily != null) {
        await notifier.setForPeriod(
            BudgetPeriod.daily, _round(amounts.daily! * baseRate, toCurrency));
      }
      if (amounts.weekly != null) {
        await notifier.setForPeriod(BudgetPeriod.weekly,
            _round(amounts.weekly! * baseRate, toCurrency));
      }
      if (amounts.monthly != null) {
        await notifier.setForPeriod(BudgetPeriod.monthly,
            _round(amounts.monthly! * baseRate, toCurrency));
      }
    }

    return baseRate != null;
  }
}
