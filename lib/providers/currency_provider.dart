import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/local/prefs_service.dart';
import '../l10n/app_localizations.dart';

const _currencyCodeKey = 'currencyCode';

/// 통화 단위 하나를 나타낸다. 언어(Locale)와 완전히 독립적으로 선택/저장된다.
class CurrencyItem {
  const CurrencyItem({
    required this.code,
    required this.symbol,
    required this.decimalDigits,
    required this.symbolBefore,
    this.groupingSeparator = ',',
    this.symbolSpacing = false,
  });

  final String code;
  final String symbol;

  /// 소수점 표시 자릿수. KRW/JPY/VND는 0, USD/EUR는 2.
  final int decimalDigits;

  /// true면 기호가 금액 앞(`$12.50`), false면 금액 뒤(`15,000₩`)에 붙는다.
  final bool symbolBefore;

  /// 천 단위 구분 기호. VND는 관례상 '.'을 쓴다(예: 250.000).
  final String groupingSeparator;

  /// true면 기호와 금액 사이에 공백을 넣는다(예: `250.000 ₫`).
  final bool symbolSpacing;

  /// 언어별로 달라지는 표시용 이름(예: "대한민국 원 (₩)")은 AppLocalizations에서 가져온다.
  String displayName(AppLocalizations loc) => switch (code) {
        'KRW' => loc.currencyNameKrw,
        'USD' => loc.currencyNameUsd,
        'JPY' => loc.currencyNameJpy,
        'EUR' => loc.currencyNameEur,
        'VND' => loc.currencyNameVnd,
        _ => code,
      };

  /// 금액을 이 통화의 기호/소수점/구분 기호 규칙에 맞춰 포맷한다.
  /// (환율 변환은 하지 않음 — 표시 형식만 적용. 실제 환산은 ExchangeRateService가 담당)
  String format(num amount) {
    final pattern = decimalDigits > 0
        ? '#,##0.${'0' * decimalDigits}'
        : '#,###';
    var formatted = NumberFormat(pattern).format(amount);
    if (groupingSeparator != ',') {
      formatted = formatted.replaceAll(',', groupingSeparator);
    }
    final spacer = symbolSpacing ? ' ' : '';
    return symbolBefore
        ? '$symbol$spacer$formatted'
        : '$formatted$spacer$symbol';
  }
}

const currencyPresets = <CurrencyItem>[
  CurrencyItem(code: 'KRW', symbol: '₩', decimalDigits: 0, symbolBefore: false),
  CurrencyItem(code: 'USD', symbol: '\$', decimalDigits: 2, symbolBefore: true),
  CurrencyItem(code: 'JPY', symbol: '¥', decimalDigits: 0, symbolBefore: true),
  CurrencyItem(code: 'EUR', symbol: '€', decimalDigits: 2, symbolBefore: true),
  CurrencyItem(
      code: 'VND',
      symbol: '₫',
      decimalDigits: 0,
      symbolBefore: false,
      groupingSeparator: '.',
      symbolSpacing: true),
];

CurrencyItem currencyByCode(String code) => currencyPresets.firstWhere(
      (c) => c.code == code,
      orElse: () => currencyPresets.first,
    );

/// 언어 코드별 기본 추천 통화. 온보딩 2단계에서 초기 선택값으로만 쓰이며,
/// 이후에는 언어와 완전히 독립적으로 관리된다.
const _suggestedCurrencyForLanguage = {
  'ko': 'KRW',
  'en': 'USD',
  'ja': 'JPY',
  'de': 'EUR',
  'vi': 'VND',
};

CurrencyItem suggestedCurrencyForLanguage(String languageCode) =>
    currencyByCode(_suggestedCurrencyForLanguage[languageCode] ?? 'KRW');

class CurrencyState {
  const CurrencyState({required this.currency, required this.isSelected});

  final CurrencyItem currency;

  /// 사용자가 통화 선택 화면에서 명시적으로 고른 적 있는지.
  /// false면 AppRoot가 온보딩에서 통화 선택 화면을 먼저 보여준다.
  final bool isSelected;
}

/// 통화 단위를 관리하고 SharedPreferences에 영구 저장한다. localeProvider(언어)와
/// 완전히 독립적인 상태로, 서로 다른 값을 자유롭게 조합해 선택할 수 있다.
class CurrencyNotifier extends Notifier<CurrencyState> {
  @override
  CurrencyState build() {
    final storedCode = PrefsService.prefs.getString(_currencyCodeKey);
    if (storedCode != null) {
      return CurrencyState(
          currency: currencyByCode(storedCode), isSelected: true);
    }
    return const CurrencyState(
        currency: CurrencyItem(
            code: 'KRW', symbol: '₩', decimalDigits: 0, symbolBefore: false),
        isSelected: false);
  }

  /// 통화 선택 화면/바텀시트에서 사용자가 명시적으로 고를 때 호출.
  Future<void> select(CurrencyItem currency) async {
    await PrefsService.prefs.setString(_currencyCodeKey, currency.code);
    state = CurrencyState(currency: currency, isSelected: true);
  }
}

final currencyProvider =
    NotifierProvider<CurrencyNotifier, CurrencyState>(CurrencyNotifier.new);
