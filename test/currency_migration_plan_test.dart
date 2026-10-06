// 통화 변경 시 중/장기 저축 플랜과 마감 주기 기록의 목표량도 함께 환산되는지 검증한다.
// 환율은 currency_migration_service_test.dart와 같이 SharedPreferences 캐시를 미리 심어
// 네트워크 없이 결정적으로 테스트한다.
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:juice/data/local/hive_service.dart';
import 'package:juice/data/local/prefs_service.dart';
import 'package:juice/data/models/card_item.dart';
import 'package:juice/data/models/category.dart';
import 'package:juice/data/models/expense.dart';
import 'package:juice/data/models/juice_saving_history.dart';
import 'package:juice/data/models/weekly_budget.dart';
import 'package:juice/providers/currency_provider.dart';
import 'package:juice/providers/savings_planner_provider.dart';
import 'package:juice/services/currency_migration_service.dart';

void _registerAdaptersOnce() {
  if (Hive.isAdapterRegistered(0)) return;
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(WeeklyBudgetAdapter());
  Hive.registerAdapter(CardItemAdapter());
  Hive.registerAdapter(JuiceSavingHistoryAdapter());
}

double _round(double amount, String code) {
  final c = currencyByCode(code);
  return c.decimalDigits > 0
      ? double.parse(amount.toStringAsFixed(c.decimalDigits))
      : amount.roundToDouble();
}

String _key(String from, String to, DateTime date) =>
    '${from}_${to}_${DateFormat('yyyy-MM-dd').format(date)}';

void main() {
  testWidgets('통화를 바꾸면 저축 플랜과 주기 기록 목표량도 환산되고, 사용자가 고친 값은 새 원본으로 인정된다',
      (tester) async {
    final tempDir = Directory.systemTemp.createTempSync('currency_migration_plan');
    addTearDown(() => tempDir.deleteSync(recursive: true));

    const krwToUsd = 0.00073;
    const krwToJpy = 0.108;
    const usdToJpy = 149.5;

    late Box settingsBox;
    late Box<JuiceSavingHistory> historyBox;

    await tester.runAsync(() async {
      Hive.init(tempDir.path);
      _registerAdaptersOnce();
      await Hive.openBox<Category>(HiveBoxes.categories);
      await Hive.openBox<Expense>(HiveBoxes.expenses);
      await Hive.openBox<WeeklyBudget>(HiveBoxes.weeklyBudgets);
      settingsBox = await Hive.openBox(HiveBoxes.settings);
      await Hive.openBox<CardItem>(HiveBoxes.cards);
      historyBox =
          await Hive.openBox<JuiceSavingHistory>(HiveBoxes.juiceSavingHistory);

      final today = DateTime.now();
      SharedPreferences.setMockInitialValues({
        'exchangeRateCache': json.encode({
          _key('KRW', 'USD', today): krwToUsd,
          _key('KRW', 'JPY', today): krwToJpy,
          _key('USD', 'JPY', today): usdToJpy,
        }),
      });
      await PrefsService.init();

      final plan = SavingsPlan(
        enabled: true,
        monthlyIncome: 2900000,
        goalYears: 5,
        goalAmount: 50000000,
        fixedExpenses: const [
          FixedExpenseItem(name: 'rent', amount: 400000, dayOfMonth: 1),
          FixedExpenseItem(name: 'fee', amount: 100000, dayOfMonth: 10),
        ],
        fixedIncomes: const [FixedIncomeItem(name: 'salary', amount: 2900000)],
        createdAt: DateTime(2025, 8, 5),
      );
      await settingsBox.put('savingsPlan', jsonEncode(plan.toJson()));

      await historyBox.put(
        'weekly_20260928',
        JuiceSavingHistory(
          id: 'weekly_20260928',
          periodType: 'weekly',
          startDate: DateTime(2026, 9, 28),
          endDate: DateTime(2026, 10, 4),
          targetAmount: 345000,
          themeEmoji: '🍊',
        ),
      );
    });

    late WidgetRef capturedRef;
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Consumer(builder: (context, ref, _) {
            capturedRef = ref;
            return const SizedBox();
          }),
        ),
      ),
    );
    await tester.pump();

    SavingsPlan readPlan() =>
        SavingsPlan.fromJson(jsonDecode(settingsBox.get('savingsPlan') as String)
            as Map<String, dynamic>);

    // 1) KRW -> USD
    late bool ok1;
    await tester.runAsync(() async {
      ok1 = await CurrencyMigrationService.migrateBaseCurrency(capturedRef,
          fromCode: 'KRW', toCode: 'USD');
    });
    expect(ok1, isTrue);

    final p1 = readPlan();
    expect(p1.goalAmount, _round(50000000 * krwToUsd, 'USD'));
    expect(p1.fixedExpenses[0].amount, _round(400000 * krwToUsd, 'USD'));
    expect(p1.fixedExpenses[1].amount, _round(100000 * krwToUsd, 'USD'));
    expect(p1.fixedExpenses[0].dayOfMonth, 1, reason: '금액 외 필드는 보존');
    expect(p1.fixedIncomes[0].amount, _round(2900000 * krwToUsd, 'USD'));
    expect(p1.monthlyIncome, p1.fixedIncomes.fold<double>(0, (s, e) => s + e.amount),
        reason: '고정수입이 있으면 월 수입은 항목 합계와 같아야 함');
    expect(p1.goalYears, 5);
    expect(p1.createdAt, DateTime(2025, 8, 5));
    expect(historyBox.get('weekly_20260928')!.targetAmount,
        _round(345000 * krwToUsd, 'USD'));

    // 2) 사용자가 USD 상태에서 목표 금액만 직접 40,000으로 수정한 뒤 USD -> JPY.
    await tester.runAsync(() async {
      await settingsBox.put('savingsPlan',
          jsonEncode(p1.copyWith(goalAmount: 40000).toJson()));
    });
    capturedRef.invalidate(savingsPlanProvider);

    late bool ok2;
    await tester.runAsync(() async {
      ok2 = await CurrencyMigrationService.migrateBaseCurrency(capturedRef,
          fromCode: 'USD', toCode: 'JPY');
    });
    expect(ok2, isTrue);

    final p2 = readPlan();
    // 직접 고친 값(40,000 USD)은 새 원본으로 취급되어 USD->JPY로 환산된다.
    expect(p2.goalAmount, _round(40000 * usdToJpy, 'JPY'));
    // 건드리지 않은 값은 최초 원본(KRW)에서 직접 환산되어 반올림 오차가 누적되지 않는다.
    expect(p2.fixedExpenses[0].amount, _round(400000 * krwToJpy, 'JPY'));
    expect(historyBox.get('weekly_20260928')!.targetAmount,
        _round(345000 * krwToJpy, 'JPY'));

    await tester.runAsync(() => Hive.close());
  });
}
