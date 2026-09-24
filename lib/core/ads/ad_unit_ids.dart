import 'dart:io';

/// AdMob 배너 광고 유닛 ID.
///
/// 지금은 구글 공식 테스트 ID를 쓰고 있어 항상 "Test Ad" 라벨이 붙은 샘플 광고만
/// 노출되고 실제 노출/클릭 수익은 발생하지 않는다. **실제 출시 전에는 AdMob 콘솔에서
/// 발급받은 프로덕션 광고 유닛 ID로 교체해야 한다.**
/// 참고: https://developers.google.com/admob/flutter/test-ads
class AdUnitIds {
  AdUnitIds._();

  static String get banner {
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/2934735716';
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/6300978111';
    throw UnsupportedError('AdMob은 iOS/Android에서만 지원돼.');
  }
}
