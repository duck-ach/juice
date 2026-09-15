import 'package:intl/intl.dart';

/// 캘린더 날짜 셀의 금액 표시 방식. [CalendarAmountDisplayMode.compact]가 기본값.
enum CalendarAmountDisplayMode { compact, full }

/// [mode]에 따라 축약형([formatCompactCalendarAmount]) 또는 콤마 구분 전체 금액을
/// 반환한다. 두 모드 모두 화폐 심볼은 붙이지 않는다(캘린더 셀 전용 — 하단 상세 내역 등
/// 심볼이 필요한 곳은 [CurrencyItem.format]을 쓸 것).
String formatCalendarAmount(
    num amount, String currencyCode, CalendarAmountDisplayMode mode) {
  if (mode == CalendarAmountDisplayMode.full) {
    return NumberFormat('#,###').format(amount.abs());
  }
  return formatCompactCalendarAmount(amount, currencyCode);
}

/// 캘린더 날짜 셀처럼 폭이 좁은 곳에서만 쓰는 통화별 컴팩트 축약 포맷터.
/// 화폐 심볼은 붙이지 않고 숫자(+ 현지 축약 단위)만 반환한다 — 통화 기호가 포함된
/// 전체 금액 포맷은 [CurrencyItem.format]을 그대로 쓸 것(하단 상세 내역 등).
String formatCompactCalendarAmount(num amount, String currencyCode) {
  final absAmount = amount.abs();

  String trimmed(double value) =>
      value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);

  switch (currencyCode.toUpperCase()) {
    case 'KRW': // 대한민국 원: 억/만 단위.
      if (absAmount >= 100000000) {
        return '${(absAmount / 100000000).toStringAsFixed(1)}억';
      } else if (absAmount >= 10000) {
        return '${trimmed(absAmount / 10000)}만';
      }
      return absAmount.toInt().toString();

    case 'JPY': // 일본 엔: 万(만) 단위.
      if (absAmount >= 10000) {
        return '${trimmed(absAmount / 10000)}万';
      }
      return absAmount.toInt().toString();

    case 'VND': // 베트남 동: tr(triệu/백만)/k(nghìn/천) 단위.
      if (absAmount >= 1000000) {
        return '${trimmed(absAmount / 1000000)}tr';
      } else if (absAmount >= 1000) {
        return '${trimmed(absAmount / 1000)}k';
      }
      return absAmount.toInt().toString();

    case 'USD': // 미국 달러 / 유로: M(백만)/k(천) 단위.
    case 'EUR':
    default:
      if (absAmount >= 1000000) {
        return '${trimmed(absAmount / 1000000)}M';
      } else if (absAmount >= 1000) {
        return '${trimmed(absAmount / 1000)}k';
      }
      return trimmed(absAmount.toDouble());
  }
}
