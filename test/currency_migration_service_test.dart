// CurrencyMigrationService 위젯 테스트.
//
// migrateBaseCurrency는 WidgetRef가 필요해 testWidgets로만 호출할 수 있는데,
// TestWidgetsFlutterBinding 아래에서는 (1) Hive의 실제 파일 I/O가 기본 fake-async 존에서
// 완료되지 않아 멈추고, (2) 실 네트워크 호출은 애초에 항상 400으로 가로채여(Flutter 테스트
// 프레임워크의 의도된 동작) fawazahmed0/currency-api를 실제로 두드릴 수 없다.
// 그래서 (1) Hive 박스 오픈/조작은 tester.runAsync()로 감싸고, (2) 환율은 실 네트워크
// 대신 ExchangeRateService가 읽는 SharedPreferences 캐시(exchangeRateCache)를 미리
// 심어 결정적으로 테스트한다 — 이 방식이 네트워크 의존 테스트보다 더 빠르고 안정적이다.
//
// 검증 목표:
// 1) 외화 원본(originalCurrency)이 있는 거래는 몇 번을 마이그레이션해도 원본(originalAmount)
//    기준으로만 재환산되어, 기준 통화가 원본과 같아지면 오차 없이 100% 복원된다.
// 2) 원본 통화 개념이 없는 일반 거래/예산 목표도 "최초 원본" 앵커에서 재환산되므로,
//    KRW->JPY->USD처럼 두 단계를 거쳐도 KRW->USD 직접 환산과 같은 값이 나온다
//    (직전 결과에 환율을 거듭 곱하는 방식이었다면 이 값과 달라졌을 것).
// 3) 마이그레이션이 완전히 성공하면 true를, 환율을 하나도 못 가져오면 false를 반환하고
//    실패한 금액은 그대로 유지된다.
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
import 'package:juice/providers/budget_settings_provider.dart';
import 'package:juice/providers/currency_provider.dart';
import 'package:juice/services/currency_migration_service.dart';

void _registerAdaptersOnce() {
  if (Hive.isAdapterRegistered(0)) return;
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(WeeklyBudgetAdapter());
  Hive.registerAdapter(CardItemAdapter());
  Hive.registerAdapter(JuiceSavingHistoryAdapter());
}

double _round(double amount, CurrencyItem currency) => currency.decimalDigits > 0
    ? double.parse(amount.toStringAsFixed(currency.decimalDigits))
    : amount.roundToDouble();

String _rateCacheKey(String from, String to, DateTime date) =>
    '${from}_${to}_${DateFormat('yyyy-MM-dd').format(date)}';

void main() {
  testWidgets(
      'KRW->JPY->USD로 두 번 통화를 바꿔도 외화 원본 거래는 100% 복원되고, '
      '일반 거래/예산은 두 단계를 거친 값과 직접 환산한 값이 같다(반올림 오차 누적 없음)',
      (tester) async {
    final tempDir =
        Directory.systemTemp.createTempSync('currency_migration_verify');
    addTearDown(() => tempDir.deleteSync(recursive: true));

    // 실제로 어떤 값인지는 중요하지 않다 — 앵커 로직이 "직전 결과에 환율을 거듭 곱하는"
    // 방식이었다면 KRW->JPY->USD 두 단계 결과가 KRW->USD 직접 환산과 달라질 수밖에
    // 없도록, 서로 다른(임의의) 값들을 쓴다.
    const krwToJpy = 0.108;
    const usdToJpy = 149.5;
    const jpyToUsd = 1 / 149.5;
    const krwToUsd = 0.00073;

    late Box<Expense> expenseBox;
    late Box settingsBox;

    await tester.runAsync(() async {
      Hive.init(tempDir.path);
      _registerAdaptersOnce();
      await Hive.openBox<Category>(HiveBoxes.categories);
      expenseBox = await Hive.openBox<Expense>(HiveBoxes.expenses);
      await Hive.openBox<WeeklyBudget>(HiveBoxes.weeklyBudgets);
      settingsBox = await Hive.openBox(HiveBoxes.settings);
      await Hive.openBox<CardItem>(HiveBoxes.cards);
      await Hive.openBox<JuiceSavingHistory>(HiveBoxes.juiceSavingHistory);

      final today = DateTime.now();
      final cache = {
        _rateCacheKey('KRW', 'JPY', today): krwToJpy,
        _rateCacheKey('USD', 'JPY', today): usdToJpy,
        _rateCacheKey('JPY', 'USD', today): jpyToUsd,
        _rateCacheKey('KRW', 'USD', today): krwToUsd,
      };
      SharedPreferences.setMockInitialValues(
          {'exchangeRateCache': json.encode(cache)});
      await PrefsService.init();

      // 국내(KRW) 일반 지출 1건: 130,000원 (원본 통화 개념 없음).
      await expenseBox.put(
        'plain1',
        Expense(id: 'plain1', amount: 130000, categoryId: 'food', date: DateTime(2026, 1, 1)),
      );

      // 외화(USD) 원본 지출 1건: $100, 저장 당시 환율 1300으로 130,000원 환산되어 있음.
      await expenseBox.put(
        'foreign1',
        Expense(
          id: 'foreign1',
          amount: 130000,
          categoryId: 'shopping',
          date: DateTime(2026, 1, 1),
          originalAmount: 100,
          originalCurrency: 'USD',
          exchangeRate: 1300,
        ),
      );

      // 주간 예산 목표 500,000원.
      await settingsBox.put('targetAmountWeekly', 500000.0);
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

    bool success1 = false;
    bool success2 = false;
    await tester.runAsync(() async {
      // 1차 마이그레이션: KRW -> JPY.
      success1 = await CurrencyMigrationService.migrateBaseCurrency(
        capturedRef,
        fromCode: 'KRW',
        toCode: 'JPY',
      );
      // 2차 마이그레이션: JPY -> USD (foreign1의 원본 통화와 동일한 통화로 되돌아감).
      success2 = await CurrencyMigrationService.migrateBaseCurrency(
        capturedRef,
        fromCode: 'JPY',
        toCode: 'USD',
      );
    });

    expect(success1, isTrue, reason: '캐시된 환율이 있으므로 마이그레이션이 완전히 성공해야 함');
    expect(success2, isTrue);

    final byId = {for (final e in expenseBox.values) e.id: e};

    // --- 검증 1: 외화 원본 거래는 기준 통화가 원본(USD)과 같아지면 오차 없이 복원 ---
    expect(byId['foreign1']!.amount, 100.0,
        reason: '두 번의 마이그레이션을 거쳐도 originalAmount(=100)로 정확히 복원되어야 함');
    expect(byId['foreign1']!.exchangeRate, 1.0);

    // --- 검증 2: 일반 거래는 "최초 원본(KRW 130,000)" 앵커에서 재환산되므로,
    // KRW->JPY->USD 두 단계를 거친 결과가 KRW->USD 직접 환산 결과와 일치해야 한다.
    // (앵커 없이 매번 직전 결과에 환율을 곱하는 구현이었다면 이 값과 달라졌을 것) ---
    final expectedPlainAmount = _round(130000 * krwToUsd, currencyByCode('USD'));
    expect(byId['plain1']!.amount, expectedPlainAmount,
        reason: '일반 거래도 최초 원본 130,000원 기준 직접 환산 값과 같아야 함(중간 단계 반올림 오차가 누적되지 않음)');
    // 만약 앵커 없이 "직전 결과에 계속 곱하는" 낡은 구현이었다면 아래 값이 나왔을 것 —
    // 실제로는 이 값과 달라야 한다(반올림 오차 누적 방지 확인).
    final naiveCompoundedAmount = _round(
        _round(130000 * krwToJpy, currencyByCode('JPY')) * jpyToUsd,
        currencyByCode('USD'));
    expect(byId['plain1']!.amount, isNot(naiveCompoundedAmount),
        reason: '단순히 직전 환산 결과에 새 환율을 곱했다면 앵커 기반 결과와 달랐을 것(이 테스트가 그 회귀를 잡아냄)');

    // --- 검증 3: 예산 목표도 같은 방식으로 원본(500,000원) 기준 재환산 ---
    final weeklyTarget = capturedRef.read(periodTargetAmountsProvider).weekly;
    final expectedWeeklyTarget = _round(500000 * krwToUsd, currencyByCode('USD'));
    expect(weeklyTarget, expectedWeeklyTarget);

    await tester.runAsync(() => Hive.close());
  });

  testWidgets('환율을 하나도 못 가져오면(캐시도 없음) false를 반환하고 금액은 그대로 유지된다',
      (tester) async {
    final tempDir = Directory.systemTemp.createTempSync('currency_migration_offline');
    addTearDown(() => tempDir.deleteSync(recursive: true));

    late Box<Expense> expenseBox;
    await tester.runAsync(() async {
      Hive.init(tempDir.path);
      _registerAdaptersOnce();
      await Hive.openBox<Category>(HiveBoxes.categories);
      expenseBox = await Hive.openBox<Expense>(HiveBoxes.expenses);
      await Hive.openBox<WeeklyBudget>(HiveBoxes.weeklyBudgets);
      await Hive.openBox(HiveBoxes.settings);
      await Hive.openBox<CardItem>(HiveBoxes.cards);
      await Hive.openBox<JuiceSavingHistory>(HiveBoxes.juiceSavingHistory);

      // 캐시를 비워둔다. 존재하지 않는 통화 코드(ZZZ/YYY)를 써서, runAsync로 실제
      // 네트워크에 진짜로 물어봐도 그 통화쌍에 대한 데이터가 없어(404) 항상 실패하도록
      // 만든다 — 이렇게 해야 "환율을 하나도 못 구한" 상황을 안정적으로 재현할 수 있다.
      SharedPreferences.setMockInitialValues({});
      await PrefsService.init();

      await expenseBox.put(
        'plain1',
        Expense(id: 'plain1', amount: 130000, categoryId: 'food', date: DateTime(2026, 1, 1)),
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

    late bool success;
    await tester.runAsync(() async {
      success = await CurrencyMigrationService.migrateBaseCurrency(
        capturedRef,
        fromCode: 'ZZZ',
        toCode: 'YYY',
      );
    });

    expect(success, isFalse,
        reason: '환율을 하나도 못 가져오면 실패로 보고해야 호출부가 기준 통화 전환을 막을 수 있음');
    expect(expenseBox.get('plain1')!.amount, 130000.0,
        reason: '환산 실패 시 금액은 그대로 유지되어야 함(통화 기호만 바뀌는 왜곡 방지)');

    await tester.runAsync(() => Hive.close());
  });
}
