import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/currency_provider.dart';
import '../settings/widgets/savings_plan_wizard.dart';
import 'short_term_budget_screen.dart';

/// 온보딩 마지막 갈림길: 단기 생활비 예산과 중·장기 저축 목표 중 먼저 시작할 쪽을
/// 고른다. 강제 연쇄 입력 대신 분기형으로, 한쪽만 완료해도 곧바로 홈으로 진입한다
/// (선택하지 않은 쪽은 설정 > 목표 설정에서 언제든 추가로 완성할 수 있다).
class GoalTypeChoiceStep extends ConsumerWidget {
  const GoalTypeChoiceStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  tooltip: loc.commonBack,
                  onPressed: () =>
                      ref.read(currencyProvider.notifier).goBackToSelection(),
                ),
              ),
              const SizedBox(height: 8),
              const Text('🍊', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 16),
              Text(
                loc.onboardingChooseGoalType,
                style: textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 32),
              _GoalTypeCard(
                emoji: '🧃',
                title: loc.onboardingShortTermTitle,
                description: loc.onboardingShortTermDesc,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => const ShortTermBudgetScreen()),
                ),
              ),
              const SizedBox(height: 16),
              _GoalTypeCard(
                emoji: '🌱',
                title: loc.onboardingLongTermTitle,
                description: loc.onboardingLongTermDesc,
                onTap: () => showSavingsPlanWizard(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoalTypeCard extends StatelessWidget {
  const _GoalTypeCard({
    required this.emoji,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final String emoji;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 36)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text(description, style: textTheme.bodyMedium),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
