import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/stats_provider.dart';

/// 월별(올해)/연도별(최근 5년) 지출 추이 막대 차트.
class SpendBarChart extends ConsumerWidget {
  const SpendBarChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final period = ref.watch(statsPeriodProvider);
    final trend = ref.watch(trendProvider);
    if (trend.isEmpty) return const SizedBox.shrink();

    String pointLabel(TrendPoint p) => period == StatsPeriod.monthly
        ? DateFormat.MMM(loc.localeName).format(DateTime(2024, p.periodValue))
        : '${p.periodValue}';

    final maxAmount =
        trend.map((t) => t.amount).fold(0.0, (a, b) => a > b ? a : b);
    final maxY = maxAmount <= 0 ? 10000.0 : maxAmount * 1.2;
    final labelStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11);

    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= trend.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(pointLabel(trend[index]), style: labelStyle),
                  );
                },
              ),
            ),
          ),
          barGroups: [
            for (var i = 0; i < trend.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: trend[i].amount,
                    color: AppColors.freshOrange,
                    width: 14,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
