import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../providers/stats_provider.dart';

/// 선택된 기간의 카테고리별 소비 비중 도넛 차트 + 범례 리스트.
class CategoryDonutChart extends ConsumerWidget {
  const CategoryDonutChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final breakdown = ref.watch(categoryBreakdownProvider);

    if (breakdown.isEmpty) {
      return SizedBox(
        height: 160,
        child: Center(
          child: Text('해당 기간에 지출 내역이 없어요',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
      );
    }

    final formatter = NumberFormat('#,###');

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 56,
              sections: breakdown.map((item) {
                final color = item.category != null
                    ? Color(item.category!.colorValue)
                    : Colors.grey;
                return PieChartSectionData(
                  value: item.amount,
                  color: color,
                  radius: 44,
                  title: item.percent >= 0.08
                      ? '${(item.percent * 100).round()}%'
                      : '',
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        for (final item in breakdown)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: item.category != null
                        ? Color(item.category!.colorValue)
                        : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(item.category?.name ?? '알 수 없음')),
                Text(
                  '${formatter.format(item.amount)}원  ${(item.percent * 100).round()}%',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
