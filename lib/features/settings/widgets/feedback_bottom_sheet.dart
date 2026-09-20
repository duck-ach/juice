import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_links.dart';
import '../../../core/utils/device_info_text.dart';
import '../../../core/utils/link_launcher.dart';
import '../../../core/widgets/juice_choice_chip.dart';
import '../../../l10n/app_localizations.dart';

enum _FeedbackType { bug, feature, other }

extension on _FeedbackType {
  String label(AppLocalizations loc) => switch (this) {
        _FeedbackType.bug => loc.feedbackTypeBug,
        _FeedbackType.feature => loc.feedbackTypeFeature,
        _FeedbackType.other => loc.feedbackTypeOther,
      };
}

/// 설정 > '문의 및 피드백 보내기'에서 여는 인앱 문의 작성 바텀시트.
/// mailto: 링크가 기기에 메일 앱이 없어 실패하는 문제를 우회해, 작성한 내용을
/// 시스템 공유 시트(Gmail/카카오톡/메모 등 사용자가 직접 선택)로 보내거나,
/// 하단의 보조 버튼으로 기본 메일 앱을 직접 열어볼 수도 있다.
class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FeedbackBottomSheet(),
    );
  }

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  _FeedbackType _type = _FeedbackType.bug;
  final _emailController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<String> _composeMessage(AppLocalizations loc) async {
    final email = _emailController.text.trim();
    final content = _contentController.text.trim();
    final deviceInfo = await buildDeviceInfoLine();
    return '[Juice Budget 피드백 - ${_type.label(loc)}]\n'
        '회신 이메일: ${email.isEmpty ? '(미입력)' : email}\n'
        '내용:\n$content\n\n'
        '---\n'
        '수신처: ${AppLinks.supportEmail}\n'
        '기기 정보: $deviceInfo';
  }

  Future<void> _submit() async {
    final loc = AppLocalizations.of(context)!;
    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(loc.feedbackContentRequired)));
      return;
    }
    final message = await _composeMessage(loc);
    if (!mounted) return;
    try {
      await Share.share(message,
          subject: '[Juice Budget 피드백 - ${_type.label(loc)}]');
    } catch (_) {
      // 공유 시트 호출 자체가 실패해도 하단의 '기본 메일 앱으로 열기'로 계속
      // 시도할 수 있으니 별도 에러 처리 없이 조용히 둔다.
    }
  }

  Future<void> _openMailApp() async {
    final loc = AppLocalizations.of(context)!;
    final message = await _composeMessage(loc);
    if (!mounted) return;
    final uri = Uri(
      scheme: 'mailto',
      path: AppLinks.supportEmail,
      query: 'subject=${Uri.encodeComponent('[Juice Budget 피드백 - ${_type.label(loc)}]')}'
          '&body=${Uri.encodeComponent(message)}',
    );
    await launchOrShowFallback(context, uri, AppLinks.supportEmail);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(loc.feedbackTitle,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: _FeedbackType.values
                      .map((type) => JuiceChoiceChip(
                            label: type.label(loc),
                            selected: _type == type,
                            onTap: () => setState(() => _type = type),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: loc.feedbackEmailHint,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _contentController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: loc.feedbackContentHint,
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  loc.feedbackDeviceInfoNotice,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Theme.of(context).hintColor),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: _submit,
                    child: Text(loc.feedbackSubmit),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: TextButton(
                    onPressed: _openMailApp,
                    child: Text(loc.feedbackOpenMailApp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
