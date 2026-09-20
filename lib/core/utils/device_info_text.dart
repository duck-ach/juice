import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 문의 메일 본문에 첨부할 한 줄짜리 기기/앱 정보(예: "iPhone15,2 · iOS 18.2,
/// Juice Budget v1.0.0+1"). 조회 실패 시에도 최대한 얻을 수 있는 정보로 대체한다.
Future<String> buildDeviceInfoLine() async {
  String appVersion;
  try {
    final packageInfo = await PackageInfo.fromPlatform();
    appVersion = 'Juice Budget v${packageInfo.version}+${packageInfo.buildNumber}';
  } catch (_) {
    appVersion = 'Juice Budget';
  }

  String osLine;
  try {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      osLine = '${info.utsname.machine} · iOS ${info.systemVersion}';
    } else if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      osLine = '${info.model} · Android ${info.version.release}';
    } else {
      osLine = Platform.operatingSystem;
    }
  } catch (_) {
    osLine = Platform.operatingSystem;
  }

  return '$osLine, $appVersion';
}
