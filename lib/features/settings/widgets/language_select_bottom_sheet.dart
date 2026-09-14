import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/locale_provider.dart';

/// 설정 > 언어 설정에서 여는 바텀시트. 옵션을 탭하면 즉시 localeProvider가 갱신되고
/// (MaterialApp이 곧바로 리빌드되어 앱 전체 언어가 바뀐다) 시트가 닫힌다.
class LanguageSelectBottomSheet extends ConsumerWidget {
  const LanguageSelectBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const LanguageSelectBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final current = ref.watch(localeProvider).locale;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.settingsLanguage,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            for (final option in supportedLanguageOptions)
              RadioListTile<String>(
                value: option.locale.languageCode,
                groupValue: current.languageCode,
                title: Text('${option.flag}  ${option.nativeName} '
                    '(${option.subLabel})'),
                onChanged: (_) {
                  ref.read(localeProvider.notifier).select(option.locale);
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ),
    );
  }
}
