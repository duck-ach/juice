import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/currency_provider.dart';
import '../../../providers/stats_provider.dart' show TrendPoint;

/// 카테고리/카드/결제수단 상세 화면 공용: 최근 N개월(마지막 포인트=당월) 추이 막대 차트.
/// 강조 막대만 고유 색으로 표시하고 나머지 달은 옅은 톤으로 표시한다. 막대 탭 시 금액 툴팁.
/// [onSelect]가 있으면 막대/하단 월 라벨 탭으로 다른 달을 선택할 수 있다.
class TrendBarChart extends ConsumerWidget {
  const TrendBarChart({
    super.key,
    required this.trend,
    required this.color,
    this.selectedIndex,
    this.onSelect,
  });

  final List<TrendPoint> trend;
  final Color color;

  /// 강조(하이라이트) 표시할 막대 인덱스. null이면 마지막(당월) 막대를 강조한다.
  final int? selectedIndex;

  /// 막대나 하단 월 라벨을 탭했을 때 호출. null이면 탭으로 선택 변경 불가(기존 동작 유지).
  final ValueChanged<int>? onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final currency = ref.watch(currencyProvider).currency;
    final maxAmount =
        trend.map((t) => t.amount).fold(0.0, (a, b) => a > b ? a : b);
    final maxY = maxAmount <= 0 ? 10000.0 : maxAmount * 1.2;
    final labelStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11);
    final highlightIndex = selectedIndex ?? trend.length - 1;

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => color,
              getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                  BarTooltipItem(
                currency.format(rod.toY),
                const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            touchCallback: onSelect == null
                ? null
                : (event, response) {
                    final index = response?.spot?.touchedBarGroupIndex;
                    if (event is! FlTapUpEvent || index == null) return;
                    onSelect!(index);
                  },
          ),
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
                  final label = DateFormat.MMM(loc.localeName)
                      .format(DateTime(2024, trend[index].periodValue));
                  final text = Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(label,
                        style: index == highlightIndex
                            ? labelStyle?.copyWith(
                                color: color, fontWeight: FontWeight.w700)
                            : labelStyle),
                  );
                  return onSelect == null
                      ? text
                      : GestureDetector(
                          onTap: () => onSelect!(index), child: text);
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
                    color: i == highlightIndex
                        ? color
                        : color.withValues(alpha: 0.35),
                    width: 18,
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
