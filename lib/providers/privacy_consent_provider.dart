import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/prefs_service.dart';

const privacyConsentKey = 'has_agreed_privacy_policy';

/// 개인정보 처리방침 최초 1회 동의 여부. 앱 첫 실행 시 언어 선택보다도 먼저
/// 노출되는 동의 화면을 한 번 통과하면 영구적으로 true가 된다.
/// '모든 데이터 초기화' 시에는 다른 설정과 함께 이 키도 지워져 다시 동의를 받는다.
class PrivacyConsentNotifier extends Notifier<bool> {
  @override
  bool build() => PrefsService.prefs.getBool(privacyConsentKey) ?? false;

  Future<void> agree() async {
    await PrefsService.prefs.setBool(privacyConsentKey, true);
    state = true;
  }
}

final privacyConsentProvider =
    NotifierProvider<PrivacyConsentNotifier, bool>(PrivacyConsentNotifier.new);
