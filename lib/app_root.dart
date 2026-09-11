import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/onboarding/onboarding_screen.dart';
import 'features/shell/main_shell.dart';
import 'providers/budget_settings_provider.dart';

/// 온보딩 완료 여부(주기별 목표 금액 중 하나라도 설정됐는지)에 따라 온보딩/대시보드를 분기.
/// 온보딩에서 목표 금액을 저장하면 periodTargetAmountsProvider 상태가 갱신되어
/// 별도 네비게이션 없이 자동으로 대시보드로 전환된다.
class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasOnboarded = ref.watch(periodTargetAmountsProvider).hasAny;
    return hasOnboarded ? const MainShell() : const OnboardingScreen();
  }
}
