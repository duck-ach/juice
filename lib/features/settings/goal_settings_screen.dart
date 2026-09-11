import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/utils/thousands_formatter.dart';
import '../../data/models/budget_period.dart';
import '../../data/models/week_start_day.dart';
import '../../providers/budget_settings_provider.dart';
import '../../providers/installment_settings_provider.dart';
import '../../providers/savings_planner_provider.dart';
import 'widgets/savings_plan_wizard.dart';

/// 목표 주기/주기별 목표 금액 + 중장기 저축 목표 플래너를 관리하는 서브 화면.
class GoalSettingsScreen extends ConsumerWidget {
  const GoalSettingsScreen({super.key});

  Future<void> _editPeriodTarget(
      BuildContext context, WidgetRef ref, BudgetPeriod period) async {
    final current =
        ref.read(periodTargetAmountsProvider).forPeriod(period) ?? 0;
    final controller =
        TextEditingController(text: NumberFormat('#,###').format(current));
    final result = await showDialog<double>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('${period.settingLabel} 목표 금액'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [ThousandsSeparatorInputFormatter()],
          textAlign: TextAlign.center,
          decoration: const InputDecoration(suffixText: 'mL'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('취소')),
          FilledButton(
            onPressed: () {
              final amount =
                  double.tryParse(controller.text.replaceAll(',', ''));
              Navigator.of(dialogContext).pop(amount);
            },
            child: const Text('저장'),
          ),
        ],
      ),
    );
    if (result != null && result > 0) {
      await ref
          .read(periodTargetAmountsProvider.notifier)
          .setForPeriod(period, result);
    }
  }

  Future<void> _pickWeekStartDay(
      BuildContext context, WidgetRef ref, WeekStartDay current) async {
    final selected = await showModalBottomSheet<WeekStartDay>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: WeekStartDay.values
              .map((d) => RadioListTile<WeekStartDay>(
                    value: d,
                    groupValue: current,
                    title: Text(d.label),
                    onChanged: (v) => Navigator.of(context).pop(v),
                  ))
              .toList(),
        ),
      ),
    );
    if (selected != null) {
      await ref.read(weekStartDayProvider.notifier).setDay(selected);
    }
  }

  /// 토글 ON: 위저드를 바로 연다. 완료 전까지는 저장하지 않으므로, 도중에 뒤로
  /// 나가면 토글은 자연히 원래 상태(꺼짐)로 남는다.
  /// 토글 OFF: 답변은 남겨둔 채 enabled만 끈다(다음에 다시 켜면 이어서 수정 가능).
  Future<void> _onToggleSavingsPlan(
      BuildContext context, WidgetRef ref, bool value) async {
    if (!value) {
      final plan = ref.read(savingsPlanProvider);
      await ref.read(savingsPlanProvider.notifier).update(
            SavingsPlan(
              enabled: false,
              monthlyIncome: plan.monthlyIncome,
              goalYears: plan.goalYears,
              goalMonths: plan.goalMonths,
              goalAmount: plan.goalAmount,
              fixedExpenses: plan.fixedExpenses,
            ),
          );
      return;
    }
    await showSavingsPlanWizard(context);
  }

  Future<void> _reapplyBudget(
      BuildContext context, WidgetRef ref, SavingsPlan plan) async {
    final monthly =
        (plan.monthlyAvailable ?? 0).clamp(0, double.infinity).toDouble();
    final daily = monthly / 30;
    final weekly = daily * 7;
    await ref
        .read(periodTargetAmountsProvider.notifier)
        .setAll(daily: daily, weekly: weekly, monthly: monthly);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('일/주/월 목표 금액이 자동 설정됐어요 🍊')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetPeriod = ref.watch(budgetPeriodProvider);
    final weekStartDay = ref.watch(weekStartDayProvider);
    final periodTargets = ref.watch(periodTargetAmountsProvider);
    final plan = ref.watch(savingsPlanProvider);
    final installmentMode = ref.watch(installmentBillingModeProvider);
    final formatter = NumberFormat('#,###');

    return Scaffold(
      appBar: AppBar(title: const Text('목표 설정')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text('활성 목표 주기', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '홈 화면 게이지가 기준으로 삼는 주기예요. 아래에서 각 주기의 목표 금액을 미리 채워두면 전환할 때 바로 반영돼요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          SegmentedButton<BudgetPeriod>(
            segments: BudgetPeriod.values
                .map(
                    (p) => ButtonSegment(value: p, label: Text(p.settingLabel)))
                .toList(),
            selected: {budgetPeriod},
            onSelectionChanged: (selection) => ref
                .read(budgetPeriodProvider.notifier)
                .setPeriod(selection.first),
          ),
          if (budgetPeriod == BudgetPeriod.weekly) ...[
            const SizedBox(height: 12),
            Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                leading: const Icon(Icons.view_week_outlined),
                title: const Text('주간 시작 요일'),
                subtitle: Text(weekStartDay.label),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _pickWeekStartDay(context, ref, weekStartDay),
              ),
            ),
          ],
          const SizedBox(height: 20),
          Text('주기별 목표 금액', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text('주기마다 목표 금액을 따로 저장해두고 필요할 때 골라 쓸 수 있어요.',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          for (final period in BudgetPeriod.values) ...[
            Card(
              margin: EdgeInsets.zero,
              color: period == budgetPeriod
                  ? Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.08)
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: period == budgetPeriod
                    ? BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5)
                    : BorderSide.none,
              ),
              child: ListTile(
                leading: const Icon(Icons.local_drink_outlined),
                title: Text('${period.settingLabel} 목표 금액'),
                subtitle: Text(
                    '${formatter.format(periodTargets.forPeriod(period) ?? 0)} mL'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _editPeriodTarget(context, ref, period),
              ),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 20),
          Text('신용카드 할부 반영 방식', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text('할부로 등록한 지출을 캘린더/주스 게이지에 언제, 어떻게 나눠 반영할지 골라주세요.',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          for (final mode in InstallmentBillingMode.values) ...[
            Card(
              margin: EdgeInsets.zero,
              color: mode == installmentMode
                  ? Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.08)
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: mode == installmentMode
                    ? BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5)
                    : BorderSide.none,
              ),
              child: RadioListTile<InstallmentBillingMode>(
                value: mode,
                groupValue: installmentMode,
                onChanged: (value) => ref
                    .read(installmentBillingModeProvider.notifier)
                    .setMode(value!),
                title: Text(mode == InstallmentBillingMode.dailyEven
                    ? '${mode.label} (추천)'
                    : mode.label),
                subtitle: Text(mode.description),
              ),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 20),
          Text('중/장기 저축 목표 플래너', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '월 수입과 고정지출, 저축 목표를 입력하면 변동지출로 쓸 수 있는 주스 용량을 계산해드려요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: plan.enabled,
            onChanged: (value) => _onToggleSavingsPlan(context, ref, value),
            title: const Text('중/장기 저축 목표가 있으신가요?'),
          ),
          if (plan.enabled && plan.isComplete) ...[
            const SizedBox(height: 12),
            _SavingsPlanSummaryCard(
              plan: plan,
              onEdit: () => showSavingsPlanWizard(context),
              onApply: () => _reapplyBudget(context, ref, plan),
            ),
          ],
        ],
      ),
    );
  }
}

/// "🍊 나의 주스 플랜" 요약 카드. 위저드를 완료하면 복잡한 폼 대신 이 카드 한 장만 보여준다.
class _SavingsPlanSummaryCard extends StatelessWidget {
  const _SavingsPlanSummaryCard(
      {required this.plan, required this.onEdit, required this.onApply});

  final SavingsPlan plan;
  final VoidCallback onEdit;
  final VoidCallback onApply;

  String get _durationLabel {
    if (plan.goalYears > 0 && plan.goalMonths > 0)
      return '${plan.goalYears}년 ${plan.goalMonths}개월';
    if (plan.goalYears > 0) return '${plan.goalYears}년';
    return '${plan.goalMonths}개월';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatter = NumberFormat('#,###');
    final monthly =
        (plan.monthlyAvailable ?? 0).clamp(0, double.infinity).toDouble();
    final weekly = monthly / 30 * 7;
    final daily = monthly / 30;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🍊 나의 주스 플랜 요약',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Text(
              '목표: $_durationLabel 동안 ${formatter.format(plan.goalAmount)}원 모으기',
              style: theme.textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text(
              '숨만 쉬어도 나가는 돈(고정비): 월 ${formatter.format(plan.fixedExpenseTotal)}원',
              style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          Text(
            '추천 주스 한 잔: 하루 ${formatter.format(daily)} mL / 이번 주 ${formatter.format(weekly)} mL / 이번 달 ${formatter.format(monthly)} mL',
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              TextButton(onPressed: onEdit, child: const Text('플랜 다시 짜기')),
              const Spacer(),
            ],
          ),
          SizedBox(
            height: 48,
            child: FilledButton(
                onPressed: onApply, child: const Text('이 예산으로 주스 자동 세팅하기')),
          ),
        ],
      ),
    );
  }
}
