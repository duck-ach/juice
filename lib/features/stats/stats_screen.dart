import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/juice_segmented_tab.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/currency_provider.dart';
import '../../providers/expense_provider.dart';
import '../../providers/juice_theme_provider.dart';
import '../../providers/stats_provider.dart';
import 'widgets/card_breakdown_list.dart';
import 'widgets/category_donut_chart.dart';
import 'widgets/payment_method_chart.dart';
import 'widgets/spend_bar_chart.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final period = ref.watch(statsPeriodProvider);
    final category = ref.watch(statsCategoryProvider);
    final filter = ref.watch(statsExpenseFilterProvider);
    final cardView = ref.watch(cardStatsViewProvider);
    final expenses = ref.watch(statsFilteredExpensesProvider);
    final total = expenses.fold(0.0, (sum, e) => sum + e.amount);
    final currency = ref.watch(currencyProvider).currency;
    final themeColor = ref.watch(resolvedJuiceThemeProvider).highColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final unselectedChipColor =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);
    final totalTitle = switch (category) {
      StatsCategory.expense => loc.totalExpenseTitle,
      StatsCategory.income => loc.statsTotalIncomeTitle,
      StatsCategory.savings => loc.statsTotalSavingsTitle,
    };
    final categoryBreakdownTitle = switch (category) {
      StatsCategory.expense => loc.categorySpendingTitle,
      StatsCategory.income => loc.incomeCategoryTitleStats,
      StatsCategory.savings => loc.savingsCategoryTitleStats,
    };

    return Scaffold(
      appBar: AppBar(title: Text(loc.statsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: StatsPeriod.values.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final p = StatsPeriod.values[index];
                final selected = p == period;
                return ChoiceChip(
                  label: Text(p.label(loc)),
                  selected: selected,
                  showCheckmark: false,
                  selectedColor:
                      themeColor.withValues(alpha: isDark ? 0.28 : 0.2),
                  labelStyle: TextStyle(
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                    color: selected ? themeColor : unselectedChipColor,
                  ),
                  onSelected: (_) =>
                      ref.read(statsPeriodProvider.notifier).state = p,
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          JuiceSegmentedTab(
            items: [loc.expenseLabel, loc.incomeLabel, loc.savingsLabel],
            selectedIndex: StatsCategory.values.indexOf(category),
            onTabChanged: (index) => ref
                .read(statsCategoryProvider.notifier)
                .state = StatsCategory.values[index],
          ),
          if (category == StatsCategory.expense) ...[
            const SizedBox(height: 12),
            JuiceSegmentedTab(
              items: [loc.filterVariableOnlyShort, loc.filterFixedIncluded],
              selectedIndex: ExpenseFilter.values.indexOf(filter),
              onTabChanged: (index) => ref
                  .read(statsExpenseFilterProvider.notifier)
                  .state = ExpenseFilter.values[index],
            ),
          ],
          const SizedBox(height: 20),
          Text(totalTitle, style: Theme.of(context).textTheme.bodyMedium),
          Text(currency.format(total),
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          if (period.isTrend) ...[
            const SpendBarChart(),
            const SizedBox(height: 24),
          ],
          Text(categoryBreakdownTitle,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const CategoryDonutChart(),
          if (category == StatsCategory.expense) ...[
            const SizedBox(height: 24),
            Text(loc.paymentMethodSpendingTitle,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            JuiceSegmentedTab(
              items: CardStatsView.values.map((v) => v.label(loc)).toList(),
              selectedIndex: CardStatsView.values.indexOf(cardView),
              onTabChanged: (index) => ref
                  .read(cardStatsViewProvider.notifier)
                  .state = CardStatsView.values[index],
            ),
            const SizedBox(height: 12),
            if (cardView == CardStatsView.summary)
              const PaymentMethodChart()
            else
              const CardBreakdownList(),
          ],
        ],
      ),
    );
  }
}
