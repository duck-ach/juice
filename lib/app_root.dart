import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/onboarding/currency_select_screen.dart';
import 'features/onboarding/language_select_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/shell/main_shell.dart';
import 'providers/budget_settings_provider.dart';
import 'providers/currency_provider.dart';
import 'providers/locale_provider.dart';

/// 온보딩 단계를 언어 선택 → 통화 선택 → 목표 예산 설정 → 대시보드 순으로 분기.
/// 각 단계가 완료되면(localeProvider.isSelected, currencyProvider.isSelected,
/// periodTargetAmountsProvider.hasAny) 해당 provider 상태가 갱신되어 별도 네비게이션
/// 없이 자동으로 다음 단계로 전환된다. 언어와 통화는 서로 완전히 독립적인 상태다.
class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasSelectedLanguage = ref.watch(localeProvider).isSelected;
    final hasSelectedCurrency = ref.watch(currencyProvider).isSelected;
    final hasOnboarded = ref.watch(periodTargetAmountsProvider).hasAny;

    final child = !hasSelectedLanguage
        ? const LanguageSelectScreen()
        : !hasSelectedCurrency
            ? const CurrencySelectScreen()
            : (hasOnboarded ? const MainShell() : const OnboardingScreen());

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: child,
    );
  }
}
