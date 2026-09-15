import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/models/budget_period.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/currency_provider.dart';
import '../../../providers/juice_saving_provider.dart';
import '../../../providers/juice_theme_provider.dart';

/// 마감된 목표 주기(일/주/월)별 절약 정산 내역을 최신순으로 보여주는 바텀시트.
/// [juiceSavingRecordsProvider]가 지출 목록을 직접 watch하므로, 과거 지출을 추가/수정/
/// 삭제하면 이 목록의 소비/절약 수치와 성공 여부가 즉시 갱신된다.
class SavingHistoryBottomSheet extends ConsumerStatefulWidget {
  const SavingHistoryBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const SavingHistoryBottomSheet(),
    );
  }

  @override
  ConsumerState<SavingHistoryBottomSheet> createState() =>
      _SavingHistoryBottomSheetState();
}

class _SavingHistoryBottomSheetState
    extends ConsumerState<SavingHistoryBottomSheet> {
  // 시트가 열려있는 동안은 고정되도록 한 번만 뽑는다(리빌드마다 문구가 바뀌지 않게).
  late final int _praiseIndex = Random().nextInt(5);

  String _praiseMessage(AppLocalizations loc) => switch (_praiseIndex) {
        0 => loc.savingPraise_1,
        1 => loc.savingPraise_2,
        2 => loc.savingPraise_3,
        3 => loc.savingPraise_4,
        _ => loc.savingPraise_5,
      };

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final records = ref.watch(juiceSavingRecordsProvider);
    final total = ref.watch(totalSavedJuiceProvider);
    final currency = ref.watch(currencyProvider).currency;
    final themeColor = ref.watch(resolvedJuiceThemeProvider).highColor;
    final formatter = NumberFormat('#,###');

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      expand: false,
      builder: (context, scrollController) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(loc.savingHistoryTitle,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            if (total > 0)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: themeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_praiseMessage(loc),
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Text(
                      loc.savingHistoryTotalLabel(
                          formatter.format(total), currency.format(total)),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w800, color: themeColor),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 12),
            Expanded(
              child: records.isEmpty
                  ? Center(
                      child: Text(
                        loc.savingHistoryEmpty,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  : ListView.separated(
                      controller: scrollController,
                      itemCount: records.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) =>
                          _SavingHistoryTile(record: records[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SavingHistoryTile extends StatelessWidget {
  const _SavingHistoryTile({required this.record});

  final JuiceSavingRecord record;

  String _periodTag(AppLocalizations loc) =>
      switch (record.history.periodTypeEnum) {
        BudgetPeriod.daily => loc.periodSettingDaily,
        BudgetPeriod.weekly => loc.periodSettingWeekly,
        BudgetPeriod.monthly => loc.periodSettingMonthly,
      };

  String _dateLabel(AppLocalizations loc) {
    final h = record.history;
    return switch (h.periodTypeEnum) {
      BudgetPeriod.daily =>
        DateFormat('M.d (E)', loc.localeName).format(h.startDate),
      BudgetPeriod.weekly =>
        '${DateFormat('M.d', loc.localeName).format(h.startDate)} - '
            '${DateFormat('M.d', loc.localeName).format(h.endDate)}',
      BudgetPeriod.monthly =>
        DateFormat.yMMMM(loc.localeName).format(h.startDate),
    };
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final formatter = NumberFormat('#,###');
    final success = record.isSuccess;
    final color =
        success ? const Color(0xFF34C759) : Theme.of(context).colorScheme.error;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(record.history.themeEmoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(_periodTag(loc),
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: color)),
                    ),
                    const SizedBox(width: 6),
                    Text(_dateLabel(loc),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  success
                      ? loc.savingHistorySuccessLine(
                          formatter.format(record.saved))
                      : loc.savingHistoryOverLine(
                          '-${formatter.format(record.spent - record.history.targetAmount)}'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: color, fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(
                  loc.savingHistoryDetailLine(
                      formatter.format(record.history.targetAmount),
                      formatter.format(record.spent)),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
