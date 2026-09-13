import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../providers/stats_provider.dart';

/// 선택된 기간의 카드별 실사용 총액과 점유율 바 그래프.
class CardBreakdownList extends ConsumerWidget {
  const CardBreakdownList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final breakdown = ref.watch(cardBreakdownProvider);

    if (breakdown.isEmpty) {
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
        for (final item in breakdown)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: item.card != null
                            ? Color(item.card!.colorValue)
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(item.card?.name ?? '카드 미지정',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    Text(
                      '${formatter.format(item.amount)} mL '
                      '(${(item.percent * 100).round()}%)',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: item.percent.clamp(0.0, 1.0),
                    minHeight: 8,
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation(item.card != null
                        ? Color(item.card!.colorValue)
                        : Colors.grey),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
