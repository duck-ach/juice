import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/category.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/asset_provider.dart';
import '../../../providers/currency_provider.dart';
import '../../../providers/juice_theme_provider.dart';

/// 자산 탭 하단의 '저축 · 투자 현황' 섹션. 이번 달 실행한 저축/투자 합계를 상단에 강조하고,
/// 그 아래 카테고리별(저축/투자/청약/ISA/비상금 등) 누적 적립액과 비중을 리스트로 보여준다.
class SavingsOverviewSection extends ConsumerWidget {
  const SavingsOverviewSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final breakdown = ref.watch(savingsCategoryBreakdownProvider);
    final allTime = ref.watch(totalSavingsProvider);
    final thisMonth = ref.watch(totalSavingsThisMonthProvider);
    final currency = ref.watch(currencyProvider).currency;
    final themeColor = ref.watch(resolvedJuiceThemeProvider).highColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(loc.savingsOverviewSectionTitle,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _SavingsStatCard(
                  label: loc.savingsAllTimeTotalLabel,
                  amount: allTime,
                  currency: currency,
                  color: themeColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SavingsStatCard(
                  label: loc.savingsThisMonthTotalLabel,
                  amount: thisMonth,
                  currency: currency,
                  color: themeColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (breakdown.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(loc.savingsOverviewEmptyMessage,
                style: Theme.of(context).textTheme.bodyMedium),
          )
        else
          for (final item in breakdown)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Color(item.category.colorValue).withValues(alpha: 0.18),
                    child: Icon(
                      IconData(item.category.iconCodePoint,
                          fontFamily:
                              item.category.iconFontFamily ?? 'MaterialIcons'),
                      color: Color(item.category.colorValue),
                    ),
                  ),
                  title: Text(item.category.getLocalizedName(context)),
                  trailing: Text(
                    '${currency.format(item.amount)} '
                    '(${(item.percent * 100).round()}%)',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}

/// '전체 누적'/'이번 달' 저축 요약을 보여주는 절반 폭 카드.
class _SavingsStatCard extends StatelessWidget {
  const _SavingsStatCard({
    required this.label,
    required this.amount,
    required this.currency,
    required this.color,
  });

  final String label;
  final double amount;
  final CurrencyItem currency;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 6),
            Text(
              currency.format(amount),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w800, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
