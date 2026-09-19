import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';

/// 온보딩 첫 단계: 앱 언어 선택 화면. 최초 실행 시 통화 선택보다 먼저 노출된다.
/// 확인을 누르면 localeProvider가 갱신되어(AppRoot가 상태를 감지) 별도 네비게이션 없이
/// 자연스럽게 다음 온보딩 단계(통화 선택)로 전환된다.
class LanguageSelectScreen extends ConsumerStatefulWidget {
  const LanguageSelectScreen({super.key});

  @override
  ConsumerState<LanguageSelectScreen> createState() =>
      _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends ConsumerState<LanguageSelectScreen> {
  late Locale _selected;

  @override
  void initState() {
    super.initState();
    final current = ref.read(localeProvider).locale;
    final currentTag = localeTag(current);
    final matched =
        supportedLanguageOptions.where((o) => o.tag == currentTag);
    _selected = matched.isNotEmpty
        ? matched.first.locale
        : supportedLanguageOptions.first.locale;
  }

  void _confirm() {
    ref.read(localeProvider.notifier).select(_selected);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text('🍊', style: TextStyle(fontSize: 56)),
              const SizedBox(height: 16),
              Text(
                loc.selectLanguage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: supportedLanguageOptions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final option = supportedLanguageOptions[index];
                    final selected = option.locale == _selected;
                    return Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: selected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: RadioListTile<Locale>(
                        value: option.locale,
                        groupValue: _selected,
                        onChanged: (value) => setState(() => _selected = value!),
                        title: Text('${option.flag}  ${option.nativeName} '
                            '(${option.subLabel})'),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: _confirm,
                  child: const Text('다음 (Next)'),
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
