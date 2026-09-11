import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/asset_provider.dart';
import 'widgets/net_flow_bar_chart.dart';

/// 수입-지출을 누적 계산한 순자산/현금 흐름 추이 화면.
class AssetsScreen extends ConsumerWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(assetPeriodProvider);
    final netWorth = ref.watch(cumulativeNetWorthProvider);
    final trend = ref.watch(assetTrendProvider);
    final periodIncome = trend.fold(0.0, (sum, p) => sum + p.income);
    final periodExpense = trend.fold(0.0, (sum, p) => sum + p.expense);
    final formatter = NumberFormat('#,###');
    final isPositive = netWorth >= 0;

    return Scaffold(
      appBar: AppBar(title: const Text('자산')),
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
                  Text('누적 순자산', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text(
                    '${isPositive ? '' : '-'}${formatter.format(netWorth.abs())} mL',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: isPositive
                              ? Colors.green.shade600
                              : Theme.of(context).colorScheme.error,
                        ),
                  ),
                  Text(
                    '지금까지 기록된 모든 수입에서 지출을 뺀 값이에요.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SegmentedButton<AssetPeriod>(
            segments: AssetPeriod.values
                .map((p) => ButtonSegment(value: p, label: Text(p.label)))
                .toList(),
            selected: {period},
            onSelectionChanged: (selection) =>
                ref.read(assetPeriodProvider.notifier).state = selection.first,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _SummaryTile(
                  label: '${period == AssetPeriod.monthly ? '올해' : '5년간'} 총 수입',
                  amount: periodIncome,
                  color: Colors.green.shade600,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryTile(
                  label: '${period == AssetPeriod.monthly ? '올해' : '5년간'} 총 지출',
                  amount: periodExpense,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text('순증감 추이', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '수입에서 지출을 뺀 순증감이에요. 초록은 흑자, 빨강은 적자예요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          const NetFlowBarChart(),
        ],
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile(
      {required this.label, required this.amount, required this.color});

  final String label;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###');
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
              '${formatter.format(amount)} mL',
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
