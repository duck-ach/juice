import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/ml_format.dart';
import '../../../core/utils/week_utils.dart';
import '../../../data/models/category.dart';
import '../../../data/models/expense.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/expense_provider.dart';
import '../../../providers/period_budget_provider.dart';

/// 게이지 계산과 같은 기준(고정지출·법인/업무용 카드 제외)의 지출만 남긴다.
bool _isVariableSpend(Expense e) =>
    !e.isIncome && !e.isSavings && !e.isFixed && !e.isCorporate;

/// 카테고리 id → 합계(내림차순).
List<MapEntry<String, double>> _sumByCategory(Iterable<Expense> expenses) {
  final sums = <String, double>{};
  for (final e in expenses) {
    sums.update(e.categoryId, (v) => v + e.amount, ifAbsent: () => e.amount);
  }
  return sums.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
}

/// 태블릿/폴더블 2단 레이아웃의 왼쪽 패널 아래쪽을 채우는 인사이트 영역:
/// 오늘의 지출 요약 카드 + 카테고리별 소진율 미니 바 차트.
class DashboardInsights extends ConsumerWidget {
  const DashboardInsights({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(24, 4, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TodaySummaryCard(),
          SizedBox(height: 12),
          _CategoryBurnCard(),
        ],
      ),
    );
  }
}

class _TodaySummaryCard extends ConsumerWidget {
  const _TodaySummaryCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final today = currentDayRange();
    final todays = ref
        .watch(expenseProvider)
        .where((e) => _isVariableSpend(e) && today.contains(e.date))
        .toList();
    final total = todays.fold(0.0, (sum, e) => sum + e.amount);
    final topId = todays.isEmpty ? null : _sumByCategory(todays).first.key;
    final categories = ref.watch(categoryProvider);
    final topCategory = categories.where((c) => c.id == topId).firstOrNull;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.homeTodaySummaryTitle, style: textTheme.titleSmall),
            const SizedBox(height: 8),
            if (todays.isEmpty)
              Text(loc.homeTodayEmptyMessage, style: textTheme.bodyMedium)
            else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${formatMl(context, total)} mL',
                        style: textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(loc.homeTodayCount(todays.length),
                      style: textTheme.bodySmall),
                ],
              ),
              if (topCategory != null) ...[
                const SizedBox(height: 4),
                Text(
                  loc.homeTodayTopCategory(
                      topCategory.getLocalizedName(context)),
                  style: textTheme.bodySmall,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

/// 현재 주기 목표 대비 카테고리별 지출 비중(= 각 카테고리가 목표를 몇 % 소진했는지) 상위 5개.
class _CategoryBurnCard extends ConsumerWidget {
  const _CategoryBurnCard();

  static const _maxRows = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final target = ref.watch(effectiveTargetAmountProvider);
    final spends = ref.watch(periodExpensesProvider).where(_isVariableSpend);
    final sums = _sumByCategory(spends).take(_maxRows).toList();
    if (target == null || target <= 0 || sums.isEmpty) {
      return const SizedBox.shrink();
    }
    final categoryMap = {for (final c in ref.watch(categoryProvider)) c.id: c};

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.homeCategoryBurnTitle,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12),
            for (final entry in sums) ...[
              _BurnBarRow(
                category: categoryMap[entry.key],
                ratio: entry.value / target,
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _BurnBarRow extends StatelessWidget {
  const _BurnBarRow({required this.category, required this.ratio});

  final Category? category;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final cat = category;
    final color = cat != null ? Color(cat.colorValue) : Colors.grey;
    final name = cat?.getLocalizedName(context) ?? loc.unknownCategoryName;
    final icon = cat != null
        ? IconData(cat.iconCodePoint,
            fontFamily: cat.iconFontFamily ?? 'MaterialIcons')
        : Icons.help_outline;

    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: color.withValues(alpha: 0.18),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: ratio.clamp(0.0, 1.0),
                  minHeight: 6,
                  color: color,
                  backgroundColor: color.withValues(alpha: 0.15),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 44,
          child: Text(
            '${(ratio * 100).round()}%',
            textAlign: TextAlign.end,
            style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
