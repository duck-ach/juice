// 일회성 개발용 스크립트: 기존 테스트 지출 데이터를 모두 지우고, 지난 12개월간 꾸준히
// 가계부를 쓴 평범한 직장인의 현실적인 지출/수입/저축 내역으로 다시 채운다.
//
// 앱 소스(lib/)를 import하면 Flutter/dart:ui 의존성이 딸려와 순수 `dart run`으로 실행할
// 수 없으므로, Expense의 Hive 바이너리 레이아웃(lib/data/models/expense.g.dart와 동일한
// typeId=1, 17필드 순서)을 이 파일 안에 그대로 복제해 독립 실행 가능하게 만들었다.
//
// 실행: dart run tool/seed_realistic_year.dart <시뮬레이터/기기 Documents 경로>
import 'dart:io';
import 'dart:math';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
final _random = Random(20260914);

class _Expense extends HiveObject {
  _Expense({
    required this.id,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.memo,
    this.isFixed = false,
    DateTime? createdAt,
    this.isIncome = false,
    this.paymentMethodName = 'checkCard',
    this.installmentMonths = 1,
    this.currentInstallmentIndex = 1,
    this.installmentGroupId,
    this.cardId,
    this.originalAmount,
    this.originalCurrency,
    this.exchangeRate,
    this.isSavings = false,
  }) : createdAt = createdAt ?? DateTime.now();

  final String id;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String? memo;
  final bool isFixed;
  final DateTime createdAt;
  final bool isIncome;
  final String paymentMethodName;
  final int installmentMonths;
  final int currentInstallmentIndex;
  final String? installmentGroupId;
  final String? cardId;
  final double? originalAmount;
  final String? originalCurrency;
  final double? exchangeRate;
  final bool isSavings;
}

class _ExpenseAdapter extends TypeAdapter<_Expense> {
  @override
  final int typeId = 1;

  @override
  _Expense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _Expense(
      id: fields[0] as String,
      amount: fields[1] as double,
      categoryId: fields[2] as String,
      date: fields[3] as DateTime,
      memo: fields[4] as String?,
      isFixed: fields[5] as bool,
      isIncome: fields[7] == null ? false : fields[7] as bool,
      createdAt: fields[6] as DateTime?,
      paymentMethodName: fields[8] == null ? 'checkCard' : fields[8] as String,
      installmentMonths: fields[9] == null ? 1 : fields[9] as int,
      currentInstallmentIndex: fields[10] == null ? 1 : fields[10] as int,
      installmentGroupId: fields[11] as String?,
      cardId: fields[12] as String?,
      originalAmount: fields[13] as double?,
      originalCurrency: fields[14] as String?,
      exchangeRate: fields[15] as double?,
      isSavings: fields[16] == null ? false : fields[16] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _Expense obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.categoryId)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.memo)
      ..writeByte(5)
      ..write(obj.isFixed)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.isIncome)
      ..writeByte(8)
      ..write(obj.paymentMethodName)
      ..writeByte(9)
      ..write(obj.installmentMonths)
      ..writeByte(10)
      ..write(obj.currentInstallmentIndex)
      ..writeByte(11)
      ..write(obj.installmentGroupId)
      ..writeByte(12)
      ..write(obj.cardId)
      ..writeByte(13)
      ..write(obj.originalAmount)
      ..writeByte(14)
      ..write(obj.originalCurrency)
      ..writeByte(15)
      ..write(obj.exchangeRate)
      ..writeByte(16)
      ..write(obj.isSavings);
  }
}

double _round(double v) => (v / 1000).round() * 1000.0;

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    stderr.writeln('사용법: dart run tool/seed_realistic_year.dart <Documents 경로>');
    exit(1);
  }
  final docsPath = args.first;
  Hive.init(docsPath);
  Hive.registerAdapter(_ExpenseAdapter());

  final expenseBox = await Hive.openBox<_Expense>('expenses');
  final historyBox = await Hive.openBox('juiceSavingHistory');
  final settingsBox = await Hive.openBox('settings');

  await expenseBox.clear();
  await historyBox.clear();
  for (final key in settingsBox.keys.toList()) {
    if (key is String && key.startsWith('juiceSavingWatermarkStart_')) {
      await settingsBox.delete(key);
    }
  }

  // 주간 주스(생활비) 목표를 20만 원으로 맞춰 시나리오와 대시보드 게이지가 일치하게 한다.
  await settingsBox.put('budgetPeriod', 'weekly');
  await settingsBox.put('targetAmountWeekly', 200000.0);
  await settingsBox.put('targetAmountDaily', 28600.0);
  await settingsBox.put('targetAmountMonthly', 860000.0);

  final today = DateTime(2026, 9, 14);
  final months = <DateTime>[];
  for (var i = 11; i >= 0; i--) {
    months.add(DateTime(today.year, today.month - i, 1));
  }

  // 경조사(4개월) / 부업 수익(6개월) 발생 달을 미리 무작위로 고른다.
  final shuffledIndices = List.generate(months.length, (i) => i)..shuffle(_random);
  final eventMonths = shuffledIndices.take(4).toSet();
  final sideIncomeMonths = shuffledIndices.skip(4).take(6).toSet();

  final variableCategories = ['food', 'cafe', 'transport', 'shopping', 'culture'];

  void addExpense({
    required DateTime date,
    required double amount,
    required String categoryId,
    bool isIncome = false,
    bool isSavings = false,
    bool isFixed = false,
    String? memo,
  }) {
    final expense = _Expense(
      id: _uuid.v4(),
      amount: amount,
      categoryId: categoryId,
      date: date,
      memo: memo,
      isFixed: isFixed,
      isIncome: isIncome,
      isSavings: isSavings,
    );
    expenseBox.put(expense.id, expense);
  }

  var totalCreated = 0;

  for (var m = 0; m < months.length; m++) {
    final month = months[m];
    final isCurrentMonth = month.year == today.year && month.month == today.month;
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final cap = isCurrentMonth ? today.day : daysInMonth;

    // 1) 매월 5일 월급.
    if (5 <= cap) {
      addExpense(
        date: DateTime(month.year, month.month, 5),
        amount: 2500000,
        categoryId: 'income_salary',
        isIncome: true,
        memo: '월급',
      );
    }

    // 2) 월급 다음날(6일) 저축/투자 4건.
    if (6 <= cap) {
      final savingsDay = DateTime(month.year, month.month, 6);
      addExpense(
          date: savingsDay,
          amount: 100000,
          categoryId: 'savings_isa',
          isSavings: true,
          memo: 'ISA 납입');
      addExpense(
          date: savingsDay,
          amount: 100000,
          categoryId: 'savings_emergency',
          isSavings: true,
          memo: '비상금 적립');
      addExpense(
          date: savingsDay,
          amount: 100000,
          categoryId: 'savings_housing',
          isSavings: true,
          memo: '주택청약 납입');
      addExpense(
          date: savingsDay,
          amount: 500000,
          categoryId: 'savings_bank',
          isSavings: true,
          memo: '청년적금');
    }

    // 3) 고정지출 4종(월 중순~하순). 아직 지나지 않은 날짜(진행 중인 이번 달)는 건너뛴다.
    final fixedBills = [
      (day: 15, amount: 30000.0, memo: '통신비'),
      (day: 20, amount: 70000.0, memo: '보험료'),
      (day: 25, amount: 108000.0, memo: '대출이자'),
      (day: 25, amount: 50000.0, memo: '관리비'),
    ];
    for (final bill in fixedBills) {
      if (bill.day <= cap) {
        addExpense(
          date: DateTime(month.year, month.month, bill.day),
          amount: bill.amount,
          categoryId: 'life',
          isFixed: true,
          memo: bill.memo,
        );
      }
    }

    // 4) 주 단위 변동지출("주스" 생활비) — 주 20만 원 기준으로 매주 무작위 변동.
    //    가중치를 살짝 낮은 쪽에 더 실어 "대체로 관리하지만 가끔 넘치는" 패턴을 만든다.
    const multipliers = [0.6, 0.75, 0.9, 1.0, 1.1, 1.3, 1.55, 1.85];
    const weights = [1, 2, 3, 4, 3, 2, 2, 1];
    final weightPool = <double>[];
    for (var i = 0; i < multipliers.length; i++) {
      weightPool.addAll(List.filled(weights[i], multipliers[i]));
    }

    var weekStart = 1;
    while (weekStart <= cap) {
      final weekEnd = min(weekStart + 6, cap);
      final daysAvailable = weekEnd - weekStart + 1;
      if (daysAvailable < 2) break; // 마지막 자투리 1~2일은 다음 달로 넘어간 것으로 취급.

      final multiplier = weightPool[_random.nextInt(weightPool.length)];
      final weekTotal = _round(200000 * multiplier);

      // 주당 지출 4~6일(무지출 데이 1~3일 자연 발생), 카테고리는 무작위 배분.
      final spendDayCount = min(4 + _random.nextInt(3), daysAvailable);
      final chosenDays = <int>{};
      while (chosenDays.length < spendDayCount) {
        chosenDays.add(weekStart + _random.nextInt(daysAvailable));
      }
      final days = chosenDays.toList()..shuffle(_random);

      // weekTotal을 spendDayCount개로 무작위 비율 분배.
      final shares = List.generate(days.length, (_) => 0.4 + _random.nextDouble());
      final shareSum = shares.fold(0.0, (a, b) => a + b);
      var remaining = weekTotal;
      for (var i = 0; i < days.length; i++) {
        final isLast = i == days.length - 1;
        final rawShare = isLast
            ? remaining
            : _round(weekTotal * (shares[i] / shareSum));
        final amount = rawShare < 3000 ? 3000.0 : rawShare;
        if (amount <= 0) continue;
        final category = variableCategories[_random.nextInt(variableCategories.length)];
        addExpense(
          date: DateTime(month.year, month.month, days[i]),
          amount: amount,
          categoryId: category,
        );
        remaining -= amount;
      }

      weekStart += 7;
    }

    // 5) 경조사(선정된 달에 한해 1건).
    if (eventMonths.contains(m) && cap >= 3) {
      final day = 3 + _random.nextInt(cap - 2);
      final amount = _round(50000 + _random.nextDouble() * 200000);
      addExpense(
        date: DateTime(month.year, month.month, day),
        amount: amount,
        categoryId: 'etc',
        memo: '경조사비',
      );
    }

    // 6) 부업 수익(선정된 달에 한해 1건, 3~5만 원).
    if (sideIncomeMonths.contains(m) && cap >= 3) {
      final day = 3 + _random.nextInt(cap - 2);
      final raw = _round(30000 + _random.nextDouble() * 20000);
      final amount = raw < 30000 ? 30000.0 : (raw > 50000 ? 50000.0 : raw);
      addExpense(
        date: DateTime(month.year, month.month, day),
        amount: amount,
        categoryId: 'income_side',
        isIncome: true,
        memo: '부업 수익',
      );
    }

    totalCreated = expenseBox.length;
  }

  await Hive.close();
  stdout.writeln('완료: 총 $totalCreated건의 지출/수입/저축 레코드를 생성했습니다.');
}
