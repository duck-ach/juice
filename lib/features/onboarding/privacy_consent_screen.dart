import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_links.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/privacy_consent_provider.dart';

/// 온보딩 맨 앞(언어 선택보다도 먼저) 딱 한 번 노출되는 개인정보 처리방침 동의 화면.
/// 동의 시 privacyConsentProvider가 영구 저장되어 다음 실행부터는 다시 뜨지 않는다.
class PrivacyConsentScreen extends ConsumerWidget {
  const PrivacyConsentScreen({super.key});

  Future<void> _openPrivacyPolicy() async {
    final uri = Uri.parse(AppLinks.privacyPolicyUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
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
                onPressed: _openPrivacyPolicy,
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
