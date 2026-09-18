import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/category.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/currency_provider.dart';
import '../../../providers/stats_provider.dart';
import '../category_detail_screen.dart';

/// 선택된 기간의 카테고리별 소비 비중 도넛 차트 + 범례 리스트.
class CategoryDonutChart extends ConsumerWidget {
  const CategoryDonutChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final breakdown = ref.watch(categoryBreakdownProvider);

    if (breakdown.isEmpty) {
      return SizedBox(
        height: 160,
        child: Center(
          child: Text(loc.noExpensesInPeriod,
              style: Theme.of(context).textTheme.bodyMedium),
        ),
      );
    }

    final currency = ref.watch(currencyProvider).currency;

    void openDetail(CategoryAmount item) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CategoryDetailScreen(
            categoryId: item.categoryId, category: item.category),
      ));
    }

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 56,
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  final index = response?.touchedSection?.touchedSectionIndex;
                  if (event is! FlTapUpEvent ||
                      index == null ||
                      index < 0 ||
                      index >= breakdown.length) {
                    return;
                  }
                  openDetail(breakdown[index]);
                },
              ),
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
          InkWell(
            onTap: () => openDetail(item),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
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
                  Expanded(
                      child: Text(item.category?.getLocalizedName(context) ??
                          loc.unknownCategoryName)),
                  Text(
                    '${currency.format(item.amount)}  ${(item.percent * 100).round()}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 2),
                  Icon(Icons.chevron_right,
                      size: 18,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withValues(alpha: 0.4)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
