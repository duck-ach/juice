import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../providers/installment_settings_provider.dart';
import '../local/hive_service.dart';
import '../models/expense.dart';
import '../models/payment_method.dart';

class ExpenseRepository {
  Box<Expense> get _box => Hive.box<Expense>(HiveBoxes.expenses);

  List<Expense> getAll() => _box.values.toList();

  Future<void> add(Expense expense) => _box.put(expense.id, expense);

  Future<void> delete(String id) => _box.delete(id);

  /// [base]를 신용카드 [months]개월 할부로 분할한다. 청구는 구매 다음 달(익월) 1일부터
  /// 시작해 매월 한 회차씩 진행되며, [mode]에 따라 반영 방식이 달라진다.
  /// - [InstallmentBillingMode.monthlyLumpNextMonth]: 회차 금액을 그 달 1일에 한 번에 반영.
  /// - [InstallmentBillingMode.dailyEven]: 회차 금액을 그 달의 일수만큼 나눠 매일 반영.
  /// 원단위 나머지는 월 단위는 1회차에, 일 단위는 각 달의 말일에 합산되고,
  /// 메모 뒤에는 회차(`(N/M회차)`)가 자동으로 붙는다.
  Future<void> addInstallment(
    Expense base,
    int months,
    InstallmentBillingMode mode,
  ) async {
    final perMonth = (base.amount / months).roundToDouble();
    final monthRemainder = base.amount - perMonth * months;
    final groupId = const Uuid().v4();
    final baseMemo = base.memo?.trim();
    var firstRecord = true;

    for (var i = 0; i < months; i++) {
      final index = i + 1;
      final monthAmount = index == 1 ? perMonth + monthRemainder : perMonth;
      final billingDate = DateTime(base.date.year, base.date.month + index, 1);
      final memo = (baseMemo == null || baseMemo.isEmpty)
          ? '($index/$months회차)'
          : '$baseMemo ($index/$months회차)';

      if (mode == InstallmentBillingMode.monthlyLumpNextMonth) {
        await _putInstallmentExpense(base,
            id: firstRecord ? base.id : const Uuid().v4(),
            amount: monthAmount,
            date: billingDate,
            memo: memo,
            months: months,
            index: index,
            groupId: groupId);
        firstRecord = false;
        continue;
      }

      final daysInBillingMonth =
          DateTime(billingDate.year, billingDate.month + 1, 0).day;
      final perDay = (monthAmount / daysInBillingMonth).roundToDouble();
      final dayRemainder = monthAmount - perDay * daysInBillingMonth;
      for (var d = 1; d <= daysInBillingMonth; d++) {
        final amount = d == daysInBillingMonth ? perDay + dayRemainder : perDay;
        await _putInstallmentExpense(base,
            id: firstRecord ? base.id : const Uuid().v4(),
            amount: amount,
            date: DateTime(billingDate.year, billingDate.month, d),
            memo: memo,
            months: months,
            index: index,
            groupId: groupId);
        firstRecord = false;
      }
    }
  }

  Future<void> _putInstallmentExpense(
    Expense base, {
    required String id,
    required double amount,
    required DateTime date,
    required String memo,
    required int months,
    required int index,
    required String groupId,
  }) {
    final expense = Expense(
      id: id,
      amount: amount,
      categoryId: base.categoryId,
      date: date,
      memo: memo,
      isFixed: base.isFixed,
      isIncome: false,
      paymentMethod: PaymentMethod.creditCard,
      installmentMonths: months,
      currentInstallmentIndex: index,
      installmentGroupId: groupId,
    );
    return _box.put(expense.id, expense);
  }
}
