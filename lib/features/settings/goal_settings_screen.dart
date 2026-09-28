import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/utils/thousands_formatter.dart';
import '../../core/widgets/juice_segmented_tab.dart';
import '../../data/models/budget_period.dart';
import '../../data/models/week_start_day.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/asset_provider.dart';
import '../../providers/budget_settings_provider.dart';
import '../../providers/installment_settings_provider.dart';
import '../../providers/saving_option_provider.dart';
import '../../providers/savings_planner_provider.dart';
import '../assets/assets_screen.dart';
import 'widgets/fixed_income_manage_sheet.dart';
import 'widgets/savings_plan_recalibration_sheet.dart';
import 'widgets/savings_plan_wizard.dart';

/// 목표 주기/주기별 목표 금액 + 중장기 저축 목표 플래너를 관리하는 서브 화면.
class GoalSettingsScreen extends ConsumerWidget {
  const GoalSettingsScreen({super.key});

  Future<void> _editPeriodTarget(BuildContext context, WidgetRef ref,
      BudgetPeriod period, AppLocalizations loc) async {
    final current =
        ref.read(periodTargetAmountsProvider).forPeriod(period) ?? 0;
    final controller =
        TextEditingController(text: NumberFormat('#,###').format(current));
    final result = await showDialog<double>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('${period.settingLabel(loc)} ${loc.periodTargetAmountSuffix}'),
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
              child: Text(loc.commonCancel)),
          FilledButton(
            onPressed: () {
              final amount =
                  double.tryParse(controller.text.replaceAll(',', ''));
              Navigator.of(dialogContext).pop(amount);
            },
            child: Text(loc.commonSave),
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

  Future<void> _pickWeekStartDay(BuildContext context, WidgetRef ref,
      WeekStartDay current, AppLocalizations loc) async {
    final selected = await showModalBottomSheet<WeekStartDay>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: WeekStartDay.values
              .map((d) => RadioListTile<WeekStartDay>(
                    value: d,
                    groupValue: current,
                    title: Text(d.label(loc)),
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
      await ref
          .read(savingsPlanProvider.notifier)
          .update(plan.copyWith(enabled: false));
      return;
    }
    await showSavingsPlanWizard(context);
  }

  Future<void> _reapplyBudget(BuildContext context, WidgetRef ref,
      SavingsPlan plan, AppLocalizations loc) async {
    final monthly =
        (plan.monthlyAvailable ?? 0).clamp(0, double.infinity).toDouble();
    final daily = monthly / 30;
    final weekly = daily * 7;
    await ref
        .read(periodTargetAmountsProvider.notifier)
        .setAll(daily: daily, weekly: weekly, monthly: monthly);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.autoBudgetSetMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final budgetPeriod = ref.watch(budgetPeriodProvider);
    final weekStartDay = ref.watch(weekStartDayProvider);
    final periodTargets = ref.watch(periodTargetAmountsProvider);
    final plan = ref.watch(savingsPlanProvider);
    final paceDeltaMonths = ref.watch(savingsPlanPaceProvider);
    final actualSavings = ref.watch(totalSavingsProvider);
    final installmentMode = ref.watch(installmentBillingModeProvider);
    final savingOption = ref.watch(savingOptionProvider);
    final formatter = NumberFormat('#,###');

    return Scaffold(
      appBar: AppBar(title: Text(loc.goalSettingsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text(loc.activePeriodSectionTitle,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            loc.activePeriodSectionDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          JuiceSegmentedTab(
            items: BudgetPeriod.values.map((p) => p.settingLabel(loc)).toList(),
            selectedIndex: BudgetPeriod.values.indexOf(budgetPeriod),
            onTabChanged: (index) => ref
                .read(budgetPeriodProvider.notifier)
                .setPeriod(BudgetPeriod.values[index]),
          ),
          if (budgetPeriod == BudgetPeriod.weekly) ...[
            const SizedBox(height: 12),
            Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                leading: const Icon(Icons.view_week_outlined),
                title: Text(loc.weekStartDayTileTitle),
                subtitle: Text(weekStartDay.label(loc)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () =>
                    _pickWeekStartDay(context, ref, weekStartDay, loc),
              ),
            ),
          ],
          const SizedBox(height: 20),
          Text(loc.periodTargetSectionTitle,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(loc.periodTargetSectionDescription,
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
                title: Text(
                    '${period.settingLabel(loc)} ${loc.periodTargetAmountSuffix}'),
                subtitle: Text(
                    '${formatter.format(periodTargets.forPeriod(period) ?? 0)} mL'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _editPeriodTarget(context, ref, period, loc),
              ),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 20),
          Text(loc.savingOptionTitle,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(loc.savingOptionDescription,
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          JuiceSegmentedTab(
            items: [loc.savingOptionRollover, loc.savingOptionSavings],
            selectedIndex: savingOption == SavingOption.rollover ? 0 : 1,
            onTabChanged: (index) => ref
                .read(savingOptionProvider.notifier)
                .setOption(
                    index == 0 ? SavingOption.rollover : SavingOption.savings),
          ),
          const SizedBox(height: 20),
          Text(loc.installmentSectionTitle,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(loc.installmentSectionDescription,
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
                    ? '${mode.label(loc)} (${loc.recommendedSuffix})'
                    : mode.label(loc)),
                subtitle: Text(mode.description(loc)),
              ),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 20),
          Text(loc.savingsPlanSectionTitle,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            loc.savingsPlanSectionDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: plan.enabled,
            onChanged: (value) => _onToggleSavingsPlan(context, ref, value),
            title: Text(loc.savingsPlanToggleTitle),
          ),
          if (plan.enabled && plan.isComplete) ...[
            const SizedBox(height: 12),
            _SavingsPlanSummaryCard(
              plan: plan,
              paceDeltaMonths: paceDeltaMonths,
              actualSavings: actualSavings,
              onEdit: () => showSavingsPlanWizard(context),
              onApply: () => _reapplyBudget(context, ref, plan, loc),
              onRecalibrate: () => SavingsPlanRecalibrationSheet.show(context),
              onManageFixedIncomes: plan.incomeType == IncomeType.fixed
                  ? () => FixedIncomeManageSheet.show(context)
                  : null,
              onViewInAssets: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AssetsScreen()),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// "🍊 나의 주스 플랜" 요약 카드. 위저드를 완료하면 복잡한 폼 대신 이 카드 한 장만 보여준다.
/// 핵심 정보(월 저축액 → 목표 달성률 → 하루/주/달 추천 예산) 순으로 시각적 위계를
/// 잡아, 번잡한 텍스트 나열 대신 헤드라인 + 그리드 구조로 한눈에 들어오게 한다.
class _SavingsPlanSummaryCard extends StatelessWidget {
  const _SavingsPlanSummaryCard({
    required this.plan,
    required this.paceDeltaMonths,
    required this.actualSavings,
    required this.onEdit,
    required this.onApply,
    required this.onRecalibrate,
    this.onManageFixedIncomes,
    required this.onViewInAssets,
  });

  final SavingsPlan plan;
  final int? paceDeltaMonths;

  /// 저축 카테고리로 실제 기록된 전체 저축/투자 누적액([totalSavingsProvider]) —
  /// 자산 탭의 '저축·투자 현황' 전체 누적과 동일한 값이라, 두 화면 수치가 항상 일치한다.
  final double actualSavings;
  final VoidCallback onEdit;
  final VoidCallback onApply;
  final VoidCallback onRecalibrate;

  /// [IncomeType.fixed]일 때만 제공 — 고정수입 CRUD 바텀시트를 연다.
  final VoidCallback? onManageFixedIncomes;

  /// 자산 탭(저축·투자 현황)으로 이동 — 같은 실제 저축액을 더 자세히 확인할 수 있음을
  /// 명시적으로 연결해준다.
  final VoidCallback onViewInAssets;

  String _durationLabel(AppLocalizations loc) {
    if (plan.goalYears > 0 && plan.goalMonths > 0) {
      return loc.durationYearsAndMonths(plan.goalYears, plan.goalMonths);
    }
    if (plan.goalYears > 0) return loc.durationYearsOnly(plan.goalYears);
    return loc.durationMonthsOnly(plan.goalMonths);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final formatter = NumberFormat('#,###');
    final monthly =
        (plan.monthlyAvailable ?? 0).clamp(0, double.infinity).toDouble();
    final weekly = monthly / 30 * 7;
    final daily = monthly / 30;
    final monthlyRequired = plan.monthlySavingsRequired ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(loc.savingsPlanSummaryTitle,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 18),
              Text(loc.savingsPlanMonthlyRequiredLabel,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: 2),
              Text(
                loc.savingsPlanMonthlyRequiredAmount(
                    formatter.format(monthlyRequired)),
                style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.primary),
              ),
              const SizedBox(height: 4),
              Text(
                  loc.savingsPlanGoalLine(
                      _durationLabel(loc), formatter.format(plan.goalAmount)),
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              const SizedBox(height: 16),
              Divider(height: 1, color: theme.dividerColor.withValues(alpha: 0.4)),
              const SizedBox(height: 16),
              _AchievementRateBlock(
                  actualSavings: actualSavings, goalAmount: plan.goalAmount ?? 0),
              if (paceDeltaMonths != null) ...[
                const SizedBox(height: 12),
                _PaceBanner(months: paceDeltaMonths!),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(loc.savingsPlanRecommendedSectionLabel,
            style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: _MiniStatCard(
                    label: loc.savingsPlanDailyGridLabel, value: daily)),
            const SizedBox(width: 8),
            Expanded(
                child: _MiniStatCard(
                    label: loc.savingsPlanWeeklyGridLabel, value: weekly)),
            const SizedBox(width: 8),
            Expanded(
                child: _MiniStatCard(
                    label: loc.savingsPlanMonthlyGridLabel, value: monthly)),
          ],
        ),
        const SizedBox(height: 16),
        Text(
            loc.savingsPlanFixedExpenseLine(
                formatter.format(plan.fixedExpenseTotal)),
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        Wrap(
          spacing: 4,
          children: [
            if (onManageFixedIncomes != null)
              TextButton.icon(
                onPressed: onManageFixedIncomes,
                icon: const Icon(Icons.payments_outlined, size: 18),
                label: Text(loc.manageFixedIncomesButton),
              ),
            TextButton.icon(
              onPressed: onViewInAssets,
              icon: const Icon(Icons.bar_chart_outlined, size: 18),
              label: Text(loc.savingsPlanViewInAssetsButton),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            TextButton(onPressed: onEdit, child: Text(loc.replanButton)),
            const Spacer(),
            TextButton.icon(
              onPressed: onRecalibrate,
              icon: const Icon(Icons.trending_up, size: 18),
              label: Text(loc.recalibrateButton),
            ),
          ],
        ),
        SizedBox(
          height: 48,
          child:
              FilledButton(onPressed: onApply, child: Text(loc.applyBudgetButton)),
        ),
      ],
    );
  }
}

/// 목표 달성률 헤드라인 — 저축 카테고리로 실제 기록된 금액 대비 목표 금액 진행률.
/// [totalSavingsProvider]를 그대로 반영하므로 저축 내역을 추가/수정/삭제하는 즉시
/// 갱신되고, 자산 탭의 '전체 누적'과 항상 같은 값을 보여준다.
class _AchievementRateBlock extends StatelessWidget {
  const _AchievementRateBlock(
      {required this.actualSavings, required this.goalAmount});

  final double actualSavings;
  final double goalAmount;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final formatter = NumberFormat('#,###');
    final progress =
        goalAmount <= 0 ? 0.0 : (actualSavings / goalAmount).clamp(0.0, 1.0);
    final percent = (progress * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(loc.savingsPlanAchievementRateLabel,
                style: theme.textTheme.bodyMedium),
            const Spacer(),
            Text('$percent%',
                style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.primary)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          loc.savingsPlanActualTraceLine(
              formatter.format(actualSavings), formatter.format(goalAmount), percent),
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

/// 현재 저축 페이스가 계획보다 빠른지/느린지/딱 맞는지 알려주는 배너.
class _PaceBanner extends StatelessWidget {
  const _PaceBanner({required this.months});

  final int months;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isGood = months >= 0;
    final color = isGood ? const Color(0xFF34C759) : theme.colorScheme.error;
    final label = months > 0
        ? loc.savingsPlanPaceFasterLine(months)
        : (months < 0
            ? loc.savingsPlanPaceSlowerLine(-months)
            : loc.savingsPlanPaceOnTrackLine);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: theme.textTheme.bodySmall
            ?.copyWith(fontWeight: FontWeight.w700, color: color),
      ),
    );
  }
}

/// 하루/이번 주/이번 달 추천 예산 그리드 셀.
class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatter = NumberFormat('#,###');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(label,
              style: theme.textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(
            '${formatter.format(value)} mL',
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w800),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
