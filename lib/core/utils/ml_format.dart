import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/currency_provider.dart';

/// 주스 용량(mL) 숫자를 선택된 기준 통화의 천 단위 구분 기호로 포맷한다. mL 값은 사실상
/// 금액이라 같은 화면의 금액 표시(예: VND/BRL의 '250.000')와 구분 기호가 어긋나 보이지
/// 않도록 맞춘다.
String formatMl(BuildContext context, num value) {
  final currency =
      ProviderScope.containerOf(context).read(currencyProvider).currency;
  return NumberFormat('#,###')
      .format(value)
      .replaceAll(',', currency.groupingSeparator);
}
