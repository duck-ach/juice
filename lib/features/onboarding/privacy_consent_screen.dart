import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_links.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/privacy_consent_provider.dart';

/// 온보딩 맨 앞(언어 선택보다도 먼저) 딱 한 번 노출되는 개인정보 처리방침 동의 화면.
/// 동의 시 privacyConsentProvider가 영구 저장되어 다음 실행부터는 다시 뜨지 않는다.
class PrivacyConsentScreen extends ConsumerWidget {
  const PrivacyConsentScreen({super.key});

  /// 열어 줄 브라우저가 없으면 launchUrl이 아무 표시 없이 false를 반환하거나
  /// 플랫폼에 따라 예외를 던지고 끝나버린다 — 탭해도 반응이 없는 것처럼 보이는
  /// 원인. 두 경우 모두 잡아 URL을 스낵바로 보여주고 복사할 수 있게 해 항상
  /// 피드백을 준다.
  Future<void> _openPrivacyPolicy(BuildContext context) async {
    final uri = Uri.parse(AppLinks.privacyPolicyUrl);
    var launched = false;
    try {
      launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      launched = false;
    }
    if (launched || !context.mounted) return;
    final loc = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(loc.linkOpenFailedMessage(AppLinks.privacyPolicyUrl)),
        action: SnackBarAction(
          label: loc.commonCopy,
          onPressed: () => Clipboard.setData(
              ClipboardData(text: AppLinks.privacyPolicyUrl)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              const Text('🍊', style: TextStyle(fontSize: 56)),
              const SizedBox(height: 16),
              Text(
                loc.privacyWelcomeTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                loc.privacyAgreeNotice,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => _openPrivacyPolicy(context),
                child: Text('${loc.viewPrivacyPolicy} >'),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: () =>
                      ref.read(privacyConsentProvider.notifier).agree(),
                  child: Text(loc.agreeAndStart),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
