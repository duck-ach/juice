import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/thousands_formatter.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/currency_provider.dart';
import '../../../providers/asset_provider.dart';
import '../../../providers/budget_settings_provider.dart';
import '../../../providers/savings_planner_provider.dart';

/// 연봉 인상/이직/외주 증가 등으로 월 수입이 바뀌었을 때, 기존 목표 금액·고정지출은
/// 건드리지 않고 수입만 갱신해 플랜을 재조정하는 바텀시트. 새 수입을 입력하면 목표
/// 금액/실제 모은 금액/남은 금액을 한눈에 보여주고, 드래그 게이지 슬라이더(+직접 입력)로
/// "이번 달 생활비(주스)를 얼마로 할지"를 자유롭게 골라 목표 기간이 어떻게 바뀌는지
/// 실시간으로 미리 보여준다 — 즉시 원터치로 확정되는 두 개의 카드 방식 대신, 그 사이
/// 어디든 연속적으로 선택할 수 있게 한 것.
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
  late final TextEditingController _weeklyBudgetController;

  /// 슬라이더가 들고 있는 실제 상태값(월 환산). 유저가 슬라이더/인풋을 만지기 전까지는
  /// null — 이 경우 build()에서 현재 플랜의 월 가용 생활비를 기본값으로 보여준다.
  double? _desiredMonthlyBudget;

  @override
  void initState() {
    super.initState();
    final plan = ref.read(savingsPlanProvider);
    _incomeController = TextEditingController(
      text: plan.monthlyIncome == null
          ? ''
          : NumberFormat('#,###').format(plan.monthlyIncome),
    );
    _weeklyBudgetController = TextEditingController();
  }

  @override
  void dispose() {
    _incomeController.dispose();
    _weeklyBudgetController.dispose();
    super.dispose();
  }

  double? get _newIncome =>
      double.tryParse(_incomeController.text.replaceAll(',', ''));

  double _monthlyToWeekly(double monthly) => monthly / 30 * 7;
  double _weeklyToMonthly(double weekly) => weekly * 30 / 7;

  void _setMonthlyBudget(double monthly) {
    setState(() => _desiredMonthlyBudget = monthly);
    _weeklyBudgetController.text =
        NumberFormat('#,###').format(_monthlyToWeekly(monthly).round());
  }

  Future<void> _apply(SavingsPlan plan, double newIncome) async {
    final loc = AppLocalizations.of(context)!;
    final newPlan =
        plan.recalibrateToBudget(newIncome, _desiredMonthlyBudget ?? 0);
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
    final actualSavings = ref.watch(totalSavingsProvider);
    final currency = ref.watch(currencyProvider).currency;
    final newIncome = _newIncome;
    final canPreview = newIncome != null && newIncome > 0;

    // 슬라이더 최대치 = 새 수입에서 고정지출을 뺀, 이번 달에 생활비로 쓸 수 있는 전체
    // 가용 재원(저축을 0으로 낮췄을 때의 극단치). 최소치는 항상 0(전액 저축).
    final maxMonthly = canPreview
        ? (newIncome - plan.fixedExpenseTotal).clamp(0, double.infinity).toDouble()
        : 0.0;
    final currentMonthly = (_desiredMonthlyBudget ??
            (plan.monthlyAvailable ?? 0).clamp(0, double.infinity).toDouble())
        .clamp(0, maxMonthly)
        .toDouble();
    if (canPreview && _weeklyBudgetController.text.isEmpty) {
      _weeklyBudgetController.text =
          NumberFormat('#,###').format(_monthlyToWeekly(currentMonthly).round());
    }
    final projectedMonths = canPreview
        ? plan.projectedTotalMonthsForBudget(newIncome, currentMonthly)
        : null;

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
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
                      suffixText: currency.symbol),
                  onChanged: (_) => setState(() {}),
                ),
                if (canPreview) ...[
                  const SizedBox(height: 20),
                  _StatRow(
                    goalAmount: plan.goalAmount ?? 0,
                    actualSavings: actualSavings,
                    currency: currency,
                    loc: loc,
                  ),
                  const SizedBox(height: 20),
                  Text(loc.recalibrateBudgetSliderLabel,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Slider(
                    value: currentMonthly,
                    min: 0,
                    max: maxMonthly <= 0 ? 1 : maxMonthly,
                    onChanged: maxMonthly <= 0
                        ? null
                        : (value) => _setMonthlyBudget(value),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _weeklyBudgetController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [ThousandsSeparatorInputFormatter()],
                          decoration: InputDecoration(
                              labelText: loc.recalibrateWeeklyBudgetLabel,
                              suffixText: currency.symbol),
                          onChanged: (text) {
                            final weekly =
                                double.tryParse(text.replaceAll(',', ''));
                            if (weekly == null) return;
                            setState(() => _desiredMonthlyBudget =
                                _weeklyToMonthly(weekly).clamp(0, maxMonthly));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      projectedMonths != null
                          ? loc.recalibratePreviewLine(
                              plan.totalMonths, projectedMonths)
                          : loc.recalibrateNoSavingsWarning,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: projectedMonths == null
                              ? Theme.of(context).colorScheme.error
                              : null),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 48,
                    child: FilledButton(
                      onPressed: () => _apply(plan, newIncome),
                      child: Text(loc.commonSave),
                    ),
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

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.goalAmount,
    required this.actualSavings,
    required this.currency,
    required this.loc,
  });

  final double goalAmount;
  final double actualSavings;
  final CurrencyItem currency;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    final remaining = (goalAmount - actualSavings).clamp(0, double.infinity);
    Widget stat(String label, double value) => Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(currency.format(value),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800)),
            ],
          ),
        );
    return Row(
      children: [
        stat(loc.recalibrateStatGoal, goalAmount),
        stat(loc.recalibrateStatSaved, actualSavings),
        stat(loc.recalibrateStatRemaining, remaining.toDouble()),
      ],
    );
  }
}
