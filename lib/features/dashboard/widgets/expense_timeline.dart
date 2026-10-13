import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/models/expense.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/currency_provider.dart';

/// 지출 목록을 날짜별로 묶어 보여주는 타임라인 뷰.
/// 날짜마다 점(●) 헤더(날짜 + 그날 합계)가 있고, 왼쪽 세로선(│)이 항목들을 이어준다.
/// [expenses]는 최신순으로 정렬돼 있어야 한다.
class ExpenseTimeline extends ConsumerWidget {
  const ExpenseTimeline({
    super.key,
    required this.expenses,
    required this.itemBuilder,
  });

  final List<Expense> expenses;
  final Widget Function(BuildContext context, Expense expense) itemBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final currency = ref.watch(currencyProvider).currency;
    final dateFormat = DateFormat('M.d (E)', loc.localeName);
    final today = DateUtils.dateOnly(DateTime.now());

    // 날짜별 묶음(입력 순서 유지).
    final groups = <DateTime, List<Expense>>{};
    for (final e in expenses) {
      groups.putIfAbsent(DateUtils.dateOnly(e.date), () => []).add(e);
    }
    // 헤더/항목을 한 줄씩 펼친 행 목록.
    final rows = <({DateTime day, Expense? expense})>[
      for (final g in groups.entries) ...[
        (day: g.key, expense: null),
        for (final e in g.value) (day: g.key, expense: e),
      ],
    ];

    String dayLabel(DateTime day) {
      final date = dateFormat.format(day);
      return switch (today.difference(day).inDays) {
        0 => '${loc.timelineToday} · $date',
        1 => '${loc.timelineYesterday} · $date',
        _ => date,
      };
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 96),
      itemCount: rows.length,
      itemBuilder: (context, index) {
        final row = rows[index];
        final expense = row.expense;
        final isFirst = index == 0;

        if (expense == null) {
          final total = groups[row.day]!.fold(0.0, (sum, e) => sum + e.amount);
          return _TimelineRow(
            isHeader: true,
            isFirst: isFirst,
            child: Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      dayLabel(row.day),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                  Text(currency.format(total),
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          );
        }
        return _TimelineRow(
          isHeader: false,
          isFirst: isFirst,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: itemBuilder(context, expense),
          ),
        );
      },
    );
  }
}

/// 타임라인 한 줄: 왼쪽 레일(세로선 + 헤더면 점) + 오른쪽 내용.
class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.isHeader,
    required this.isFirst,
    required this.child,
  });

  final bool isHeader;
  final bool isFirst;
  final Widget child;

  static const _railWidth = 28.0;
  static const _dotSize = 12.0;
  static const _dotTop = 8.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: _railWidth,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // 세로선: 첫 줄은 점 중심부터 시작해 모든 줄을 이어 내려간다.
                Positioned(
                  top: isFirst ? _dotTop + _dotSize / 2 : 0,
                  bottom: 0,
                  child: SizedBox(
                    width: 2,
                    child: ColoredBox(color: scheme.outlineVariant),
                  ),
                ),
                if (isHeader)
                  Positioned(
                    top: _dotTop,
                    child: Container(
                      width: _dotSize,
                      height: _dotSize,
                      decoration: BoxDecoration(
                        color: scheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: scheme.surface, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
