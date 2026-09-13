import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/expense_provider.dart';
import '../../providers/stats_provider.dart';
import 'widgets/card_breakdown_list.dart';
import 'widgets/category_donut_chart.dart';
import 'widgets/payment_method_chart.dart';
import 'widgets/spend_bar_chart.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(statsPeriodProvider);
    final filter = ref.watch(statsExpenseFilterProvider);
    final cardView = ref.watch(cardStatsViewProvider);
    final expenses = ref.watch(statsFilteredExpensesProvider);
    final total = expenses.fold(0.0, (sum, e) => sum + e.amount);
    final formatter = NumberFormat('#,###');

    return Scaffold(
      appBar: AppBar(title: const Text('통계')),
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
                return ChoiceChip(
                  label: Text(p.label),
                  selected: p == period,
                  onSelected: (_) =>
                      ref.read(statsPeriodProvider.notifier).state = p,
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          SegmentedButton<ExpenseFilter>(
            segments: const [
              ButtonSegment(
                  value: ExpenseFilter.variableOnly, label: Text('변동지출만')),
              ButtonSegment(value: ExpenseFilter.all, label: Text('고정비 포함')),
            ],
            selected: {filter},
            onSelectionChanged: (selection) => ref
                .read(statsExpenseFilterProvider.notifier)
                .state = selection.first,
          ),
          const SizedBox(height: 20),
          Text('총 지출', style: Theme.of(context).textTheme.bodyMedium),
          Text('${formatter.format(total)}원',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          if (period.isTrend) ...[
            const SpendBarChart(),
            const SizedBox(height: 24),
          ],
          Text('카테고리별 소비', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const CategoryDonutChart(),
          const SizedBox(height: 24),
          Text('결제 수단별 소비', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          SegmentedButton<CardStatsView>(
            segments: CardStatsView.values
                .map((v) => ButtonSegment(value: v, label: Text(v.label)))
                .toList(),
            selected: {cardView},
            onSelectionChanged: (selection) => ref
                .read(cardStatsViewProvider.notifier)
                .state = selection.first,
          ),
          const SizedBox(height: 12),
          if (cardView == CardStatsView.summary)
            const PaymentMethodChart()
          else
            const CardBreakdownList(),
        ],
      ),
    );
  }
}
