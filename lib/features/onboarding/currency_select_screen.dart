import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/currency_provider.dart';
import '../../providers/locale_provider.dart';

/// 온보딩 두 번째 단계: 통화 단위 선택 화면. 언어 선택 직후, 목표 예산 설정보다
/// 먼저 노출된다. 1단계에서 고른 언어에 맞춰 기본 통화를 미리 체크해 두지만,
/// 사용자는 자유롭게 다른 통화로 바꿀 수 있다(언어와 통화는 완전히 독립적으로 저장됨).
class CurrencySelectScreen extends ConsumerStatefulWidget {
  const CurrencySelectScreen({super.key});

  @override
  ConsumerState<CurrencySelectScreen> createState() =>
      _CurrencySelectScreenState();
}

class _CurrencySelectScreenState extends ConsumerState<CurrencySelectScreen> {
  late CurrencyItem _selected;

  @override
  void initState() {
    super.initState();
    if (hasChosenCurrencyBefore) {
      _selected = ref.read(currencyProvider).currency;
    } else {
      final locale = ref.read(localeProvider).locale;
      _selected = suggestedCurrencyForLocale(locale);
    }
  }

  void _confirm() {
    ref.read(currencyProvider.notifier).select(_selected);
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
              const Text('💰', style: TextStyle(fontSize: 56)),
              const SizedBox(height: 16),
              Text(
                loc.currencySelectTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: currencyPresets.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final option = currencyPresets[index];
                    final selected = option.code == _selected.code;
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
                      child: RadioListTile<String>(
                        value: option.code,
                        groupValue: _selected.code,
                        onChanged: (_) => setState(() => _selected = option),
                        title: Text(option.displayName(loc)),
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
                  child: Text(loc.commonDone),
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
