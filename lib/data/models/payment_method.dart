import '../../l10n/app_localizations.dart';

/// 지출 결제 수단. Hive에는 [Expense.paymentMethodName]으로 이름(name) 문자열이 저장된다.
enum PaymentMethod { checkCard, creditCard, cash }

extension PaymentMethodLabel on PaymentMethod {
  String label(AppLocalizations loc) => switch (this) {
        PaymentMethod.checkCard => loc.paymentCheckCard,
        PaymentMethod.creditCard => loc.paymentCreditCard,
        PaymentMethod.cash => loc.paymentCash,
      };

  String get emoji => switch (this) {
        PaymentMethod.checkCard => '💳',
        PaymentMethod.creditCard => '💳',
        PaymentMethod.cash => '💵',
      };
}
