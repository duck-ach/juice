// FixedExpenseAutoFillService가 dayOfMonth=31("말일") 항목을 각 달의 실제 마지막
// 날짜로 clamp해서 캘린더에 기입하는지 검증한다 — 31일이 있는 달(1월)은 31일,
// 30일까지인 달(4월)은 30일, 2월은 평년/윤년에 따라 28일/29일에 기입돼야 한다.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:juice/data/local/hive_service.dart';
import 'package:juice/data/models/expense.dart';
import 'package:juice/providers/savings_planner_provider.dart';
import 'package:juice/services/fixed_expense_autofill_service.dart';

void _registerAdaptersOnce() {
  if (Hive.isAdapterRegistered(1)) return;
  Hive.registerAdapter(ExpenseAdapter());
}

void main() {
  test('말일(31일) 지급일은 매월 실제 마지막 날짜로 자동 보정된다', () async {
    final tempDir = Directory.systemTemp.createTempSync('fixed_expense_autofill_verify');
    Hive.init(tempDir.path);
    _registerAdaptersOnce();

    final expenseBox = await Hive.openBox<Expense>(HiveBoxes.expenses);
    final settingsBox = await Hive.openBox(HiveBoxes.settings);

    // 평년(2025)에서 시작해 윤년(2028) 2월까지, 1월/4월/2월(평년)/2월(윤년)을 모두 거친다.
    final plan = SavingsPlan(
      fixedExpenses: const [
        FixedExpenseItem(name: '월세(말일)', amount: 500000, dayOfMonth: 31),
      ],
    );
    await settingsBox.put('savingsPlan', jsonEncode(plan.toJson()));

    final container = ProviderContainer();
    addTearDown(container.dispose);

    Future<void> runCheck(DateTime now) => container.read(
        FutureProvider<void>((ref) => FixedExpenseAutoFillService.checkAndFillCurrentMonth(ref, now: now))
            .future);

    // 최초 실행(1월) — 기준선만 잡고 1월분을 즉시 채운다.
    await runCheck(DateTime(2025, 1, 15));
    // 이후 4월까지 건너뛰어 2월(평년)/3월/4월분을 한 번에 소급 생성.
    await runCheck(DateTime(2025, 4, 15));

    final byMonth = {
      for (final e in expenseBox.values) '${e.date.year}-${e.date.month}': e.date.day,
    };

    expect(byMonth['2025-1'], 31, reason: '31일이 있는 1월은 31일 그대로');
    expect(byMonth['2025-2'], 28, reason: '평년 2월은 28일로 clamp');
    expect(byMonth['2025-3'], 31, reason: '31일이 있는 3월은 31일 그대로');
    expect(byMonth['2025-4'], 30, reason: '30일까지인 4월은 30일로 clamp');

    // 윤년(2028) 2월로 건너뛰어 29일로 clamp되는지 확인.
    await runCheck(DateTime(2028, 2, 10));
    final byMonthAfterLeap = {
      for (final e in expenseBox.values) '${e.date.year}-${e.date.month}': e.date.day,
    };
    expect(byMonthAfterLeap['2028-2'], 29, reason: '윤년 2월은 29일로 clamp');

    await Hive.close();
    tempDir.deleteSync(recursive: true);
  });
}
