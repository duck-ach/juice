import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/prefs_service.dart';

const _localeLanguageCodeKey = 'localeLanguageCode';

const _supportedLanguageCodes = ['ko', 'en', 'ja', 'de', 'vi'];

class LanguageOption {
  const LanguageOption(this.locale, this.flag, this.nativeName, this.subLabel);

  final Locale locale;
  final String flag;
  final String nativeName;
  final String subLabel;
}

/// 언어 선택 화면(온보딩)과 설정 > 언어 설정 바텀시트가 공유하는 옵션 목록.
const supportedLanguageOptions = [
  LanguageOption(Locale('ko'), '🇰🇷', '한국어', 'Korean'),
  LanguageOption(Locale('en'), '🇺🇸', 'English', '영어'),
  LanguageOption(Locale('ja'), '🇯🇵', '日本語', '일본어'),
  LanguageOption(Locale('de'), '🇩🇪', 'Deutsch', '독일어'),
  LanguageOption(Locale('vi'), '🇻🇳', 'Tiếng Việt', '베트남어'),
];

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
    final storedCode = prefs.getString(_localeLanguageCodeKey);
    if (storedCode != null) {
      return LocaleState(locale: Locale(storedCode), isSelected: true);
    }

    final deviceCode = PlatformDispatcher.instance.locale.languageCode;
    final fallbackCode =
        _supportedLanguageCodes.contains(deviceCode) ? deviceCode : 'ko';
    return LocaleState(locale: Locale(fallbackCode), isSelected: false);
  }

  /// 언어 선택 화면/바텀시트에서 사용자가 명시적으로 언어를 고를 때 호출.
  Future<void> select(Locale locale) async {
    await PrefsService.prefs
        .setString(_localeLanguageCodeKey, locale.languageCode);
    state = LocaleState(locale: locale, isSelected: true);
  }
}

final localeProvider =
    NotifierProvider<LocaleNotifier, LocaleState>(LocaleNotifier.new);
