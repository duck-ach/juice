import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    this.decimalSeparator = '.',
    this.symbolSpacing = false,
  });

  final String code;
  final String symbol;

  /// 소수점 표시 자릿수. KRW/JPY/VND는 0, USD/EUR는 2.
  final int decimalDigits;

  /// true면 기호가 금액 앞(`$12.50`), false면 금액 뒤(`15,000₩`)에 붙는다.
  final bool symbolBefore;

  /// 천 단위 구분 기호. VND/BRL은 관례상 '.'을 쓴다(예: 250.000).
  final String groupingSeparator;

  /// 소수점 구분 기호. BRL은 관례상 ','을 쓴다(예: 1.234,56).
  final String decimalSeparator;

  /// true면 기호와 금액 사이에 공백을 넣는다(예: `250.000 ₫`).
  final bool symbolSpacing;

  /// 언어별로 달라지는 표시용 이름(예: "대한민국 원 (₩)")은 AppLocalizations에서 가져온다.
  String displayName(AppLocalizations loc) => switch (code) {
        'KRW' => loc.currencyNameKrw,
        'USD' => loc.currencyNameUsd,
        'JPY' => loc.currencyNameJpy,
        'EUR' => loc.currencyNameEur,
        'VND' => loc.currencyNameVnd,
        'TWD' => loc.currencyNameTwd,
        'CNY' => loc.currencyNameCny,
        'BRL' => loc.currencyNameBrl,
        _ => code,
      };

  /// 금액을 이 통화의 기호/소수점/구분 기호 규칙에 맞춰 포맷한다.
  /// (환율 변환은 하지 않음 — 표시 형식만 적용. 실제 환산은 ExchangeRateService가 담당)
  /// intl의 로케일 기본 구분 기호에 의존하지 않고 직접 그룹핑해, 그룹/소수 구분
  /// 기호가 둘 다 기본값과 다른 통화(BRL 등)도 정확히 표시한다.
  String format(num amount) {
    final isNegative = amount < 0;
    final fixed = amount.abs().toStringAsFixed(decimalDigits);
    final digits = decimalDigits > 0
        ? fixed.substring(0, fixed.length - decimalDigits - 1)
        : fixed;
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(groupingSeparator);
      }
      buffer.write(digits[i]);
    }
    var formatted = buffer.toString();
    if (decimalDigits > 0) {
      formatted += decimalSeparator + fixed.substring(fixed.length - decimalDigits);
    }
    if (isNegative) formatted = '-$formatted';
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
  CurrencyItem(
      code: 'TWD', symbol: 'NT\$', decimalDigits: 0, symbolBefore: true),
  CurrencyItem(code: 'CNY', symbol: '¥', decimalDigits: 2, symbolBefore: true),
  CurrencyItem(
      code: 'BRL',
      symbol: 'R\$',
      decimalDigits: 2,
      symbolBefore: true,
      groupingSeparator: '.',
      decimalSeparator: ',',
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
  'fr': 'EUR',
  'pt': 'BRL',
};

/// 중국어는 스크립트(번체/간체)에 따라 추천 통화가 다르므로 [Locale] 기준으로 판단한다
/// (번체=대만 TWD, 간체=중국 CNY).
CurrencyItem suggestedCurrencyForLocale(Locale locale) {
  if (locale.languageCode == 'zh') {
    return currencyByCode(locale.scriptCode == 'Hant' ? 'TWD' : 'CNY');
  }
  return currencyByCode(
      _suggestedCurrencyForLanguage[locale.languageCode] ?? 'KRW');
}

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

  /// 온보딩에서 뒤로가기로 통화 선택 화면에 되돌아갈 때 호출. 이미 저장된 통화
  /// 값(prefs)은 그대로 두고 isSelected만 꺼서 AppRoot가 CurrencySelectScreen을
  /// 다시 보여주게 한다.
  void goBackToSelection() {
    state = CurrencyState(currency: state.currency, isSelected: false);
  }
}

/// prefs에 통화 코드가 저장된 적이 있는지. isSelected는 온보딩 뒤로가기로 다시
/// false가 될 수 있어, "이전에 한 번이라도 확정한 적 있는지"는 이 값으로 판단한다.
bool get hasChosenCurrencyBefore =>
    PrefsService.prefs.getString(_currencyCodeKey) != null;

final currencyProvider =
    NotifierProvider<CurrencyNotifier, CurrencyState>(CurrencyNotifier.new);
