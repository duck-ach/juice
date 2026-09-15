import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/utils/thousands_formatter.dart';
import '../../core/widgets/juice_choice_chip.dart';
import '../../core/widgets/juice_segmented_tab.dart';
import '../../data/models/budget_period.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/budget_settings_provider.dart';
import '../../providers/currency_provider.dart';

/// 온보딩 갈림길의 [가벼운 단기 생활비 예산] 카드에서 진입하는 화면. 일/주/월 목표
/// 금액만 정하고 곧바로 홈으로 들어간다 — 중·장기 저축 목표 화면은 거치지 않는다.
class ShortTermBudgetScreen extends ConsumerStatefulWidget {
  const ShortTermBudgetScreen({super.key});

  @override
  ConsumerState<ShortTermBudgetScreen> createState() =>
      _ShortTermBudgetScreenState();
}

class _ShortTermBudgetScreenState
    extends ConsumerState<ShortTermBudgetScreen> {
  final _numberFormat = NumberFormat('#,###');
  final _budgetController = TextEditingController();
  BudgetPeriod _period = BudgetPeriod.weekly;
  bool _saving = false;

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  double? get _budgetAmount =>
      double.tryParse(_budgetController.text.replaceAll(',', ''));

  List<double> _quickAmountsFor(BudgetPeriod period, String currencyCode) {
    final weekly = switch (currencyCode) {
      'USD' || 'EUR' => const [50.0, 75.0, 100.0, 150.0],
      'JPY' => const [10000.0, 15000.0, 20000.0, 30000.0],
      'VND' => const [1000000.0, 1500000.0, 2000000.0, 3000000.0],
      _ => const [100000.0, 150000.0, 200000.0, 300000.0], // KRW 등 기본값
    };
    return switch (period) {
      BudgetPeriod.weekly => weekly,
      BudgetPeriod.daily => weekly.map((v) => _roundNice(v / 7)).toList(),
      BudgetPeriod.monthly => weekly.map((v) => _roundNice(v * 4)).toList(),
    };
  }

  double _roundNice(double value) {
    if (value >= 10000) return (value / 1000).round() * 1000;
    if (value >= 1000) return (value / 100).round() * 100;
    if (value >= 100) return (value / 10).round() * 10;
    return value.roundToDouble();
  }

  Future<void> _submit() async {
    if (_saving || (_budgetAmount ?? 0) <= 0) return;
    setState(() => _saving = true);
    await ref.read(budgetPeriodProvider.notifier).setPeriod(_period);
    await ref
        .read(periodTargetAmountsProvider.notifier)
        .setForPeriod(_period, _budgetAmount!);
    // 저장 즉시 periodTargetAmountsProvider.hasAny가 true가 되어 AppRoot가 뒤에서
    // MainShell로 전환해 두므로, 이 화면을 pop하면 곧바로 홈이 드러난다.
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final currency = ref.watch(currencyProvider).currency;
    final periodLabel = switch (_period) {
      BudgetPeriod.daily => loc.onboardingBudgetLabelDaily,
      BudgetPeriod.weekly => loc.onboardingBudgetLabelWeekly,
      BudgetPeriod.monthly => loc.onboardingBudgetLabelMonthly,
    };
    final quickAmounts = _quickAmountsFor(_period, currency.code);
    final canProceed = (_budgetAmount ?? 0) > 0;

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
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      const Text('🍊', style: TextStyle(fontSize: 48)),
                      const SizedBox(height: 16),
                      Text(loc.onboardingStep1Title,
                          style: textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text(
                        loc.onboardingStep1Subtitle(currency.symbol),
                        style: textTheme.bodyMedium
                            ?.copyWith(color: Theme.of(context).hintColor),
                      ),
                      const SizedBox(height: 28),
                      JuiceSegmentedTab(
                        items: [
                          loc.periodSettingDaily,
                          '${loc.periodSettingWeekly} (${loc.recommendedSuffix})',
                          loc.periodSettingMonthly,
                        ],
                        selectedIndex: BudgetPeriod.values.indexOf(_period),
                        onTabChanged: (index) => setState(() {
                          _period = BudgetPeriod.values[index];
                          _budgetController.clear();
                        }),
                      ),
                      const SizedBox(height: 24),
                      Text(periodLabel, style: textTheme.titleSmall),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _budgetController,
                        autofocus: true,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [ThousandsSeparatorInputFormatter()],
                        style: textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                        decoration: InputDecoration(
                          hintText: '0',
                          suffixText: currency.symbol,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final amount in quickAmounts)
                            JuiceChoiceChip(
                              label: currency.format(amount),
                              selected: _budgetAmount == amount,
                              onTap: () => setState(() {
                                _budgetController.text =
                                    _numberFormat.format(amount);
                              }),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                loc.onboardingFooterHint,
                textAlign: TextAlign.center,
                style: textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: (_saving || !canProceed) ? null : _submit,
                  child: Text(loc.startWithJuice),
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
