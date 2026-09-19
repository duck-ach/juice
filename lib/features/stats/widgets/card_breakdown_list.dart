import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/currency_provider.dart';
import '../../../providers/stats_provider.dart';
import '../card_detail_screen.dart';

/// 선택된 기간의 카드별 실사용 총액과 점유율 바 그래프.
class CardBreakdownList extends ConsumerWidget {
  const CardBreakdownList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final breakdown = ref.watch(cardBreakdownProvider);

    if (breakdown.isEmpty) {
      return SizedBox(
        height: 120,
        child: Center(
          child: Text(loc.noExpensesInPeriod,
              style: Theme.of(context).textTheme.bodyMedium),
        ),
      );
    }

    final currency = ref.watch(currencyProvider).currency;

    return Column(
      children: [
        for (final item in breakdown)
          InkWell(
            onTap: item.card == null
                ? null
                : () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CardDetailScreen(card: item.card!),
                    )),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
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
                        child: Text(item.card?.name ?? loc.cardUnassigned,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      Text(
                        '${currency.format(item.amount)} '
                        '(${(item.percent * 100).round()}%)',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      if (item.card != null) ...[
                        const SizedBox(width: 2),
                        Icon(Icons.chevron_right,
                            size: 18,
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color
                                ?.withValues(alpha: 0.4)),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: item.percent.clamp(0.0, 1.0),
                      minHeight: 8,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation(item.card != null
                          ? Color(item.card!.colorValue)
                          : Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
