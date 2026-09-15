// JuiceSavingService.checkAndClosePeriods의 "하루 지나면 오늘치가 마감되는지" 워터마크
// 로직과, 저장된 히스토리를 건드리지 않고도 최신 지출로 spent/saved가 다시 계산되는지
// (retroactive 반영) 검증하는 회귀 테스트. 실제 기기/시뮬레이터 시계를 바꾸지 않고도
// now 파라미터로 "다음 날"을 주입해 마감 시점을 재현한다.
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:juice/data/local/hive_service.dart';
import 'package:juice/data/models/card_item.dart';
import 'package:juice/data/models/category.dart';
import 'package:juice/data/models/expense.dart';
import 'package:juice/data/models/juice_saving_history.dart';
import 'package:juice/data/models/payment_method.dart';
import 'package:juice/data/models/weekly_budget.dart';
import 'package:juice/providers/saving_option_provider.dart';
import 'package:juice/services/juice_saving_service.dart';

void _registerAdaptersOnce() {
  if (Hive.isAdapterRegistered(0)) return;
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(WeeklyBudgetAdapter());
  Hive.registerAdapter(CardItemAdapter());
  Hive.registerAdapter(JuiceSavingHistoryAdapter());
}

void main() {
  test('daily period closes correctly one day later, with live spend recalculated', () async {
    final tempDir = Directory.systemTemp.createTempSync('juice_saving_verify');
    Hive.init(tempDir.path);
    _registerAdaptersOnce();

    await Hive.openBox<Category>(HiveBoxes.categories);
    final expenseBox = await Hive.openBox<Expense>(HiveBoxes.expenses);
    await Hive.openBox<WeeklyBudget>(HiveBoxes.weeklyBudgets);
    final settingsBox = await Hive.openBox(HiveBoxes.settings);
    await Hive.openBox<CardItem>(HiveBoxes.cards);
    await Hive.openBox<JuiceSavingHistory>(HiveBoxes.juiceSavingHistory);

    // "오늘"(9/14)을 활성 주기=일간, 목표 500,000mL로 세팅.
    await settingsBox.put('budgetPeriod', 'daily');
    await settingsBox.put('targetAmountDaily', 500000.0);
    await settingsBox.put('juiceThemeType', 'grape');

    final today = DateTime(2026, 9, 14);
    // 9/14 변동지출 두 건(120,000 + 30,000 = 150,000), 고정지출 한 건(50,000, 계산에서 제외돼야 함).
    await expenseBox.put(
      'e1',
      Expense(
          id: 'e1',
          amount: 120000,
          categoryId: 'food',
          date: today.add(const Duration(hours: 9)),
          paymentMethod: PaymentMethod.checkCard),
    );
    await expenseBox.put(
      'e2',
      Expense(
          id: 'e2',
          amount: 30000,
          categoryId: 'cafe',
          date: today.add(const Duration(hours: 14)),
          paymentMethod: PaymentMethod.checkCard),
    );
    await expenseBox.put(
      'e3-fixed',
      Expense(
          id: 'e3-fixed',
          amount: 50000,
          categoryId: 'life',
          date: today.add(const Duration(hours: 20)),
          isFixed: true,
          paymentMethod: PaymentMethod.checkCard),
    );

    final container = ProviderContainer();
    addTearDown(container.dispose);

    // 1차 호출: "오늘"(9/14) 시점에 처음 실행 — 최초 실행이므로 지금 이 순간을 기준선으로만
    // 삼고 과거를 소급 생성하지 않는다(아직 9/14도 끝나지 않았으니 당연히 닫히지 않아야 함).
    final baselineCheck = FutureProvider<void>(
        (ref) => JuiceSavingService.checkAndClosePeriods(ref, now: today.add(const Duration(hours: 8))));
    await container.read(baselineCheck.future);
    expect(JuiceSavingService.getAll(), isEmpty,
        reason: '최초 실행 시점(9/14 당일)에는 아직 마감된 주기가 없어야 함');

    // 2차 호출: "내일"(9/15)로 시계를 넘겨서 다시 호출 — 이제 9/14 하루가 완전히 지났으므로
    // 마감 레코드가 생성돼야 한다.
    final tomorrow = DateTime(2026, 9, 15, 10, 0);
    final checkProvider = FutureProvider<void>(
        (ref) => JuiceSavingService.checkAndClosePeriods(ref, now: tomorrow));
    await container.read(checkProvider.future);

    final history = JuiceSavingService.getAll();
    final allExpenses = expenseBox.values.toList();

    print('--- 마감된 히스토리 레코드 수: ${history.length} ---');
    for (final h in history) {
      final spent = h.spentAmount(allExpenses);
      final saved = h.savedAmount(allExpenses);
      final success = h.isSuccess(allExpenses);
      print('id=${h.id} periodType=${h.periodType} '
          'start=${h.startDate} end=${h.endDate} '
          'target=${h.targetAmount} themeEmoji=${h.themeEmoji} '
          '=> spent=$spent saved=$saved isSuccess=$success');
    }

    expect(history.length, 1, reason: '9/14 하루치 daily 주기 1건만 마감되어야 함');
    final closed = history.single;
    expect(closed.periodType, 'daily');
    expect(closed.startDate, DateTime(2026, 9, 14));
    expect(closed.targetAmount, 500000.0);
    expect(closed.themeEmoji, '🍇');

    final spent = closed.spentAmount(allExpenses);
    final saved = closed.savedAmount(allExpenses);
    final success = closed.isSuccess(allExpenses);
    expect(spent, 150000.0, reason: '고정지출 50,000은 제외하고 변동지출 120,000+30,000만 합산');
    expect(saved, 350000.0);
    expect(success, true);

    // --- 재계산 검증: 마감된 "과거" 날짜에 지출을 뒤늦게(retroactive) 추가하면
    // 저장된 레코드를 건드리지 않아도 spent/saved가 즉시 달라지는지 확인 ---
    await expenseBox.put(
      'e4-late',
      Expense(
          id: 'e4-late',
          amount: 100000,
          categoryId: 'shopping',
          date: today.add(const Duration(hours: 11)),
          paymentMethod: PaymentMethod.checkCard),
    );
    final updatedExpenses = expenseBox.values.toList();
    final spentAfterLateEntry = closed.spentAmount(updatedExpenses);
    final savedAfterLateEntry = closed.savedAmount(updatedExpenses);
    print('--- 지연 입력(100,000 추가) 후 재계산: '
        'spent=$spentAfterLateEntry saved=$savedAfterLateEntry ---');
    expect(spentAfterLateEntry, 250000.0);
    expect(savedAfterLateEntry, 250000.0);

    await Hive.close();
    tempDir.deleteSync(recursive: true);
  });

  test('rollover option chains leftover budget into each following period', () async {
    final tempDir = Directory.systemTemp.createTempSync('juice_saving_rollover');
    Hive.init(tempDir.path);
    _registerAdaptersOnce();

    await Hive.openBox<Category>(HiveBoxes.categories);
    final expenseBox = await Hive.openBox<Expense>(HiveBoxes.expenses);
    await Hive.openBox<WeeklyBudget>(HiveBoxes.weeklyBudgets);
    final settingsBox = await Hive.openBox(HiveBoxes.settings);
    await Hive.openBox<CardItem>(HiveBoxes.cards);
    await Hive.openBox<JuiceSavingHistory>(HiveBoxes.juiceSavingHistory);

    await settingsBox.put('budgetPeriod', 'daily');
    await settingsBox.put('targetAmountDaily', 500000.0);
    await settingsBox.put('juiceThemeType', 'orange');
    await settingsBox.put('savingOption', SavingOption.rollover.name);

    final day1 = DateTime(2026, 9, 14);
    final day2 = DateTime(2026, 9, 15);
    final day3 = DateTime(2026, 9, 16);
    // day1: 100,000 소비(목표 500,000 중 400,000 남음).
    await expenseBox.put('d1',
        Expense(id: 'd1', amount: 100000, categoryId: 'food', date: day1.add(const Duration(hours: 9))));
    // day2: 200,000 소비.
    await expenseBox.put('d2',
        Expense(id: 'd2', amount: 200000, categoryId: 'food', date: day2.add(const Duration(hours: 9))));
    // day3: 50,000 소비.
    await expenseBox.put('d3',
        Expense(id: 'd3', amount: 50000, categoryId: 'food', date: day3.add(const Duration(hours: 9))));

    final container = ProviderContainer();
    addTearDown(container.dispose);

    // day1 이른 시각에 기준선을 세우고, day3가 다 지난 뒤(9/17) 한 번에 3일치를 마감한다
    // — 여러 날을 건너뛰어도 오래된 순서로 이월이 순차적으로 이어지는지 확인.
    await container.read(FutureProvider<void>((ref) =>
        JuiceSavingService.checkAndClosePeriods(ref, now: day1.add(const Duration(hours: 8)))).future);
    await container.read(FutureProvider<void>((ref) => JuiceSavingService
        .checkAndClosePeriods(ref, now: DateTime(2026, 9, 17, 10))).future);

    final history = JuiceSavingService.getAll()
      ..sort((a, b) => a.startDate.compareTo(b.startDate));
    final allExpenses = expenseBox.values.toList();

    print('--- 이월 체인 검증 ---');
    for (final h in history) {
      print('start=${h.startDate} target=${h.targetAmount} '
          'saved=${h.savedAmount(allExpenses)} savingOption=${h.savingOption}');
    }

    expect(history.length, 3);
    expect(history[0].targetAmount, 500000.0, reason: '첫날은 이월할 이전 기록이 없음');
    expect(history[0].savedAmount(allExpenses), 400000.0);
    expect(history[0].savingOption, 'rollover');

    expect(history[1].targetAmount, 900000.0, reason: '500,000 + day1 이월분 400,000');
    expect(history[1].savedAmount(allExpenses), 700000.0);

    expect(history[2].targetAmount, 1200000.0, reason: '500,000 + day2 이월분 700,000');
    expect(history[2].savedAmount(allExpenses), 1150000.0);

    await Hive.close();
    tempDir.deleteSync(recursive: true);
  });
}
