/// 지출 결제 수단. Hive에는 [Expense.paymentMethodName]으로 이름(name) 문자열이 저장된다.
enum PaymentMethod { checkCard, creditCard, cash, splitBill }

extension PaymentMethodLabel on PaymentMethod {
  String get label => switch (this) {
        PaymentMethod.checkCard => '체크카드',
        PaymentMethod.creditCard => '신용카드',
        PaymentMethod.cash => '현금·이체',
        PaymentMethod.splitBill => '더치페이',
      };

  String get emoji => switch (this) {
        PaymentMethod.checkCard => '💳',
        PaymentMethod.creditCard => '💳',
        PaymentMethod.cash => '💵',
        PaymentMethod.splitBill => '🧾',
      };
}
