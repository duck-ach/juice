import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/thousands_formatter.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/budget_settings_provider.dart';
import '../../../providers/savings_planner_provider.dart';

/// 연봉 인상/이직/외주 증가 등으로 월 수입이 바뀌었을 때, 기존 목표 금액·기간·고정지출은
/// 건드리지 않고 수입만 갱신해 플랜을 재조정하는 바텀시트. 새 수입을 입력하면 "목표 기간
/// 단축하기"와 "생활비(주스) 늘리기" 두 옵션의 결과를 미리 보여주고, 선택한 쪽을 바로 적용한다.
class SavingsPlanRecalibrationSheet extends ConsumerStatefulWidget {
  const SavingsPlanRecalibrationSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SavingsPlanRecalibrationSheet(),
    );
  }

  @override
  ConsumerState<SavingsPlanRecalibrationSheet> createState() =>
      _SavingsPlanRecalibrationSheetState();
}

class _SavingsPlanRecalibrationSheetState
    extends ConsumerState<SavingsPlanRecalibrationSheet> {
  late final TextEditingController _incomeController;

  @override
  void initState() {
    super.initState();
    final plan = ref.read(savingsPlanProvider);
    _incomeController = TextEditingController(
      text: plan.monthlyIncome == null
          ? ''
          : NumberFormat('#,###').format(plan.monthlyIncome),
    );
  }

  @override
  void dispose() {
    _incomeController.dispose();
    super.dispose();
  }

  double? get _newIncome =>
      double.tryParse(_incomeController.text.replaceAll(',', ''));

  Future<void> _apply(SavingsPlan newPlan) async {
    final loc = AppLocalizations.of(context)!;
    final monthly =
        (newPlan.monthlyAvailable ?? 0).clamp(0, double.infinity).toDouble();
    final daily = monthly / 30;
    final weekly = daily * 7;
    await ref.read(savingsPlanProvider.notifier).update(newPlan);
    await ref
        .read(periodTargetAmountsProvider.notifier)
        .setAll(daily: daily, weekly: weekly, monthly: monthly);
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(loc.autoBudgetSetMessage)));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final plan = ref.watch(savingsPlanProvider);
    final formatter = NumberFormat('#,###');
    final newIncome = _newIncome;
    final canPreview = newIncome != null && newIncome > 0;

    final shortened =
        canPreview ? plan.recalibrateShortenDuration(newIncome) : null;
    final canShorten =
        shortened != null && shortened.totalMonths < plan.totalMonths;
    final boosted =
        canPreview ? plan.recalibrateIncreaseBudget(newIncome) : null;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      child: Text(loc.recalibrateSheetTitle,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(loc.recalibrateSheetSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16),
                TextField(
                  controller: _incomeController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [ThousandsSeparatorInputFormatter()],
                  style: Theme.of(context).textTheme.headlineSmall,
                  decoration: InputDecoration(
                      labelText: loc.recalibrateIncomeFieldLabel,
                      suffixText: loc.wonUnit),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 20),
                if (canPreview) ...[
                  _RecalibrationOptionCard(
                    title: loc.recalibrateShortenOption,
                    description: canShorten
                        ? loc.recalibrateShortenPreview(
                            plan.totalMonths, shortened.totalMonths)
                        : loc.recalibrateShortenUnavailable,
                    onTap: canShorten ? () => _apply(shortened) : null,
                  ),
                  const SizedBox(height: 12),
                  _RecalibrationOptionCard(
                    title: loc.recalibrateBoostOption,
                    description: loc.recalibrateBoostPreview(
                        formatter.format(plan.dailyAvailable ?? 0),
                        formatter.format(boosted!.dailyAvailable ?? 0)),
                    onTap: () => _apply(boosted),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecalibrationOptionCard extends StatelessWidget {
  const _RecalibrationOptionCard({
    required this.title,
    required this.description,
    required this.onTap,
  });

  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final enabled = onTap != null;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: enabled
              ? theme.colorScheme.primary.withValues(alpha: 0.08)
              : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: enabled
                ? theme.colorScheme.primary.withValues(alpha: 0.3)
                : theme.colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: enabled ? null : theme.disabledColor)),
                  const SizedBox(height: 4),
                  Text(description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: enabled ? null : theme.disabledColor)),
                ],
              ),
            ),
            if (enabled)
              Icon(Icons.chevron_right, color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
