import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/juice_segmented_tab.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/asset_provider.dart';
import '../../providers/currency_provider.dart';
import '../../providers/juice_saving_provider.dart';
import '../../providers/juice_theme_provider.dart';
import 'widgets/net_flow_bar_chart.dart';
import 'widgets/savings_overview_section.dart';

/// 수입-지출을 누적 계산한 순자산/현금 흐름 추이 화면.
class AssetsScreen extends ConsumerWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final period = ref.watch(assetPeriodProvider);
    final netWorth = ref.watch(cumulativeNetWorthProvider);
    final periodSummary = ref.watch(assetPeriodSummaryProvider);
    final periodIncome = periodSummary.income;
    final periodExpense = periodSummary.expense;
    final isPositive = netWorth >= 0;
    final periodScopeLabel =
        period == AssetPeriod.monthly ? loc.scopeThisMonth : loc.scopeThisYear;
    final accumulatedSavings = ref.watch(totalAccumulatedSavingsProvider);
    final currency = ref.watch(currencyProvider).currency;
    final themeColor = ref.watch(resolvedJuiceThemeProvider).highColor;

    return Scaffold(
      appBar: AppBar(title: Text(loc.assetsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(loc.cumulativeNetWorthLabel,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text(
                    '${isPositive ? '' : '-'}${currency.format(netWorth.abs())}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: isPositive
                              ? Colors.green.shade600
                              : Theme.of(context).colorScheme.error,
                        ),
                  ),
                  Text(
                    loc.cumulativeNetWorthDescription,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          if (accumulatedSavings > 0) ...[
            const SizedBox(height: 12),
            Card(
              margin: EdgeInsets.zero,
              color: themeColor.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loc.savingsAssetCardTitle,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(
                      currency.format(accumulatedSavings),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800, color: themeColor),
                    ),
                    const SizedBox(height: 4),
                    Text(loc.savingsAssetCardDescription,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
          JuiceSegmentedTab(
            items: AssetPeriod.values.map((p) => p.label(loc)).toList(),
            selectedIndex: AssetPeriod.values.indexOf(period),
            onTabChanged: (index) => ref.read(assetPeriodProvider.notifier).state =
                AssetPeriod.values[index],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _SummaryTile(
                  label: loc.totalIncomeLabel(periodScopeLabel),
                  amount: periodIncome,
                  color: Colors.green.shade600,
                  currency: currency,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryTile(
                  label: loc.totalExpenseLabel(periodScopeLabel),
                  amount: periodExpense,
                  color: Theme.of(context).colorScheme.error,
                  currency: currency,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(loc.netChangeTrendTitle,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            loc.netChangeTrendDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          const NetFlowBarChart(),
          const SizedBox(height: 28),
          const SavingsOverviewSection(),
        ],
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.amount,
    required this.color,
    required this.currency,
  });

  final String label;
  final double amount;
  final Color color;
  final CurrencyItem currency;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 4),
            Text(
              currency.format(amount),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: color, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
