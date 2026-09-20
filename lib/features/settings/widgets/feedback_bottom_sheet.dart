import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/app_links.dart';
import '../../../core/utils/device_info_text.dart';
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
/// [FlutterEmailSender]로 수신자/제목/본문/첨부파일이 채워진 OS 기본 메일
/// 작성 화면을 바로 열고, 메일 앱이 없는 기기에서는 내용을 클립보드에
/// 복사해 안내한다.
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

const _maxImages = 2;

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  _FeedbackType _type = _FeedbackType.bug;
  final _emailController = TextEditingController();
  final _contentController = TextEditingController();
  final List<XFile> _images = [];

  @override
  void dispose() {
    _emailController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_images.length >= _maxImages) return;
    final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 85);
    if (picked != null && mounted) setState(() => _images.add(picked));
  }

  Future<String> _composeMessage(AppLocalizations loc) async {
    final email = _emailController.text.trim();
    final content = _contentController.text.trim();
    final deviceInfo = await buildDeviceInfoLine();
    return '회신 이메일: ${email.isEmpty ? '(미입력)' : email}\n'
        '내용:\n$content\n\n'
        '---\n'
        '기기 정보: $deviceInfo';
  }

  Future<void> _submit() async {
    final loc = AppLocalizations.of(context)!;
    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(loc.feedbackContentRequired)));
      return;
    }
    final email = _emailController.text.trim();
    final message = await _composeMessage(loc);
    if (!mounted) return;
    final typeLabel = _type.label(loc);
    final subject =
        '[Juice Budget] $typeLabel${email.isEmpty ? '' : ' - $email'}';
    final mail = Email(
      body: message,
      subject: subject,
      recipients: [AppLinks.supportEmail],
      attachmentPaths: [for (final image in _images) image.path],
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(mail);
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      await Clipboard.setData(ClipboardData(text: message));
      if (!mounted) return;
      // 바텀시트가 열린 채로는 SnackBar가 시트 뒤에 가려 보이지 않으므로,
      // 시트를 먼저 닫고 부모 화면의 ScaffoldMessenger로 안내한다.
      final messenger = ScaffoldMessenger.of(context);
      Navigator.of(context).pop();
      messenger.showSnackBar(
          SnackBar(content: Text(loc.feedbackMailUnavailable)));
    }
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
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: _images.length >= _maxImages ? null : _pickImage,
                    icon: const Icon(Icons.add_photo_alternate_outlined, size: 18),
                    label: Text(loc.feedbackAttachImage),
                  ),
                ),
                if (_images.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [for (final image in _images) _buildThumbnail(image)],
                  ),
                ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(XFile image) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(File(image.path),
              width: 70, height: 70, fit: BoxFit.cover),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: GestureDetector(
            onTap: () => setState(() => _images.remove(image)),
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                  color: Colors.black54, shape: BoxShape.circle),
              child: const Icon(Icons.close, size: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
