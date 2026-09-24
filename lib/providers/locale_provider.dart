import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/prefs_service.dart';

const _localeTagKey = 'localeLanguageCode';

class LanguageOption {
  const LanguageOption(this.locale, this.nativeName);

  final Locale locale;

  /// 해당 언어의 고유 명칭(Native Name)만 표시 — 괄호 안 한국어 서브 라벨은 쓰지 않는다
  /// (외국어 환경에서 한국어 텍스트가 섞여 보이는 부자연스러움을 없애기 위함).
  /// 국기 이모지도 쓰지 않는다 — 번체/간체 중국어처럼 국가 하나로 대표할 수 없는
  /// 언어가 섞여 있어, 일부만 국기를 빼면 오히려 형평성 문제로 보일 수 있다.
  final String nativeName;

  /// 언어/스크립트를 함께 구분하는 고유 키(예: 'zh_Hant', 'ko'). 언어 선택 UI에서
  /// 그룹핑/선택 상태 비교에 쓴다 — languageCode만 쓰면 zh_Hant/zh_Hans이 서로
  /// 구분되지 않는다.
  String get tag => localeTag(locale);
}

/// [locale]을 저장/비교용 고유 문자열로 변환(예: 'zh_Hant', 'pt', 'ko').
String localeTag(Locale locale) => locale.scriptCode == null
    ? locale.languageCode
    : '${locale.languageCode}_${locale.scriptCode}';

/// [tag]([localeTag] 형식)를 다시 [Locale]로 변환.
Locale localeFromTag(String tag) {
  final parts = tag.split('_');
  if (parts.length == 2) {
    return Locale.fromSubtags(languageCode: parts[0], scriptCode: parts[1]);
  }
  return Locale(tag);
}

/// 언어 선택 화면(온보딩)과 설정 > 언어 설정 바텀시트가 공유하는 옵션 목록.
const supportedLanguageOptions = [
  LanguageOption(Locale('ko'), '한국어'),
  LanguageOption(Locale('en'), 'English'),
  LanguageOption(Locale('ja'), '日本語'),
  LanguageOption(Locale('de'), 'Deutsch'),
  LanguageOption(Locale('vi'), 'Tiếng Việt'),
  LanguageOption(
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'), '繁體中文'),
  LanguageOption(
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'), '简体中文'),
  LanguageOption(Locale('fr'), 'Français'),
  LanguageOption(Locale('pt'), 'Português'),
];

final _supportedTags = supportedLanguageOptions.map((o) => o.tag).toSet();

class LocaleState {
  const LocaleState({required this.locale, required this.isSelected});

  final Locale locale;

  /// 사용자가 언어 선택 화면에서 명시적으로 언어를 고른 적 있는지.
  /// false면 AppRoot가 대시보드/예산 온보딩 대신 언어 선택 화면을 먼저 보여준다.
  final bool isSelected;
}

/// 앱 언어(Locale)만 관리하고 SharedPreferences에 영구 저장한다. 통화 단위는
/// currencyProvider가 완전히 독립적으로 관리한다.
/// 아직 사용자가 고른 적 없으면 기기 시스템 언어를 기본값으로 자동 감지한다(지원 언어 밖이면 한국어).
class LocaleNotifier extends Notifier<LocaleState> {
  @override
  LocaleState build() {
    final prefs = PrefsService.prefs;
    final storedTag = prefs.getString(_localeTagKey);
    if (storedTag != null && _supportedTags.contains(storedTag)) {
      return LocaleState(locale: localeFromTag(storedTag), isSelected: true);
    }

    final device = PlatformDispatcher.instance.locale;
    // 중국어는 스크립트로 번체/간체를 구분(대만/홍콩=Hant, 그 외=Hans 기본값).
    final deviceTag = device.languageCode == 'zh'
        ? (device.scriptCode == 'Hant' ||
                device.countryCode == 'TW' ||
                device.countryCode == 'HK' ||
                device.countryCode == 'MO'
            ? 'zh_Hant'
            : 'zh_Hans')
        : device.languageCode;
    final fallbackTag = _supportedTags.contains(deviceTag) ? deviceTag : 'ko';
    return LocaleState(locale: localeFromTag(fallbackTag), isSelected: false);
  }

  /// 언어 선택 화면/바텀시트에서 사용자가 명시적으로 언어를 고를 때 호출.
  Future<void> select(Locale locale) async {
    await PrefsService.prefs.setString(_localeTagKey, localeTag(locale));
    state = LocaleState(locale: locale, isSelected: true);
  }
}

final localeProvider =
    NotifierProvider<LocaleNotifier, LocaleState>(LocaleNotifier.new);
