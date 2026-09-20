import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';

/// [uri]를 열어 줄 앱(메일/브라우저 등)이 기기에 없으면 launchUrl이 아무 표시 없이
/// false를 반환하거나(예: 시뮬레이터에서 메일 계정 미설정) 플랫폼에 따라 예외를 던지고
/// 끝나버린다 — 탭해도 반응이 없는 것처럼 보이는 원인. 두 경우 모두 잡아 대상
/// (이메일/URL)을 스낵바로 보여주고 복사할 수 있게 해 항상 피드백을 준다.
Future<void> launchOrShowFallback(
  BuildContext context,
  Uri uri,
  String displayTarget, {
  LaunchMode? mode,
}) async {
  var launched = false;
  try {
    launched = await launchUrl(uri, mode: mode ?? LaunchMode.platformDefault);
  } catch (_) {
    launched = false;
  }
  if (launched || !context.mounted) return;
  final loc = AppLocalizations.of(context)!;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(loc.linkOpenFailedMessage(displayTarget)),
      action: SnackBarAction(
        label: loc.commonCopy,
        onPressed: () => Clipboard.setData(ClipboardData(text: displayTarget)),
      ),
    ),
  );
}
