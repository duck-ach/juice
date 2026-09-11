import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/models/payment_method.dart';
import '../../../providers/stats_provider.dart';

const _paymentMethodColors = {
  PaymentMethod.checkCard: Colors.blueAccent,
  PaymentMethod.creditCard: Colors.deepOrangeAccent,
  PaymentMethod.cash: Colors.green,
  PaymentMethod.splitBill: Colors.purpleAccent,
};

/// 선택된 기간의 결제 수단별(체크카드/신용카드/현금) 소비 비중 도넛 차트 + 요약 카드.
class PaymentMethodChart extends ConsumerWidget {
  const PaymentMethodChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final breakdown = ref.watch(paymentMethodBreakdownProvider);
    final total = breakdown.fold(0.0, (sum, b) => sum + b.amount);

    if (total <= 0) {
      return SizedBox(
        height: 120,
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
          height: 180,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 50,
              sections: breakdown
                  .where((b) => b.amount > 0)
                  .map((b) => PieChartSectionData(
                        value: b.amount,
                        color: _paymentMethodColors[b.method],
                        radius: 40,
                        title: b.percent >= 0.08
                            ? '${(b.percent * 100).round()}%'
                            : '',
                        titleStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        for (final b in breakdown)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _paymentMethodColors[b.method],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(b.method.emoji),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(b.method == PaymentMethod.creditCard
                      ? '${b.method.label} (할부 포함)'
                      : b.method.label),
                ),
                Text(
                  '${formatter.format(b.amount)}원  ${(b.percent * 100).round()}%',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
