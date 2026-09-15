import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/week_utils.dart';
import '../data/models/category.dart';
import '../data/models/expense.dart';
import '../l10n/app_localizations.dart';
import 'category_provider.dart';
import 'expense_provider.dart';

enum AssetPeriod { monthly, yearly }

extension AssetPeriodLabel on AssetPeriod {
  String label(AppLocalizations loc) => switch (this) {
        AssetPeriod.monthly => loc.statsPeriodMonthly,
        AssetPeriod.yearly => loc.statsPeriodYearly,
      };
}

final assetPeriodProvider =
    StateProvider<AssetPeriod>((ref) => AssetPeriod.monthly);

class AssetPoint {
  const AssetPoint(
      {required this.periodValue, required this.income, required this.expense});

  /// 월별 모드에서는 월(1~12), 연도별 모드에서는 연도(예: 2026).
  /// 화면에 표시할 라벨 문자열은 BuildContext가 있는 위젯 쪽에서 로케일에 맞게 만든다.
  final int periodValue;
  final double income;
  final double expense;

  double get net => income - expense;
}

/// 지금까지 기록된 모든 수입-지출 누적 합 — '순자산' 요약 카드에 사용. 저축/투자는 소비가
/// 아닌 자산 내 이동(통장→저축)이므로 순자산 증감에 영향을 주지 않는다(0으로 처리).
final cumulativeNetWorthProvider = Provider<double>((ref) {
  final all = ref.watch(expenseProvider);
  return all.fold(0.0, (sum, e) {
    if (e.isSavings) return sum;
    return sum + (e.isIncome ? e.amount : -e.amount);
  });
});

/// 월별(올해 1~12월) / 연도별(최근 5년) 수입·지출·순증감 추이.
final assetTrendProvider = Provider<List<AssetPoint>>((ref) {
  final period = ref.watch(assetPeriodProvider);
  final all = ref.watch(expenseProvider);

  AssetPoint pointFor(int periodValue, Iterable<Expense> items) {
    final income =
        items.where((e) => e.isIncome).fold(0.0, (s, e) => s + e.amount);
    final expense = items
        .where((e) => !e.isIncome && !e.isSavings)
        .fold(0.0, (s, e) => s + e.amount);
    return AssetPoint(periodValue: periodValue, income: income, expense: expense);
  }

  if (period == AssetPeriod.monthly) {
    final year = DateTime.now().year;
    return List.generate(12, (i) {
      final month = i + 1;
      final items =
          all.where((e) => e.date.year == year && e.date.month == month);
      return pointFor(month, items);
    });
  }

  final currentYear = DateTime.now().year;
  return List.generate(5, (i) {
    final year = currentYear - 4 + i;
    final items = all.where((e) => e.date.year == year);
    return pointFor(year, items);
  });
});

/// 상단 요약 카드(총 수입/총 지출)가 쓰는 "현재 기간" 딱 한 구간의 값.
/// [assetTrendProvider]는 그래프용으로 12개월/5개년 전체 포인트를 반환하므로, 이를 그대로
/// fold하면 월별 모드에서도 사실상 연간 합계가 나오는 버그가 생긴다 — 월별 모드는 현재
/// 달 포인트 하나만, 연도별 모드는 현재 해 포인트 하나만 집어 반환한다.
final assetPeriodSummaryProvider = Provider<AssetPoint>((ref) {
  final period = ref.watch(assetPeriodProvider);
  final trend = ref.watch(assetTrendProvider);
  final now = DateTime.now();
  final currentValue = period == AssetPeriod.monthly ? now.month : now.year;
  return trend.firstWhere(
    (p) => p.periodValue == currentValue,
    orElse: () => AssetPoint(periodValue: currentValue, income: 0, expense: 0),
  );
});

class SavingsCategoryAmount {
  const SavingsCategoryAmount(
      {required this.category, required this.amount, required this.percent});

  final Category category;
  final double amount;
  final double percent;
}

/// 저축 카테고리별 누적 적립 금액(전체 기간, 내림차순) — 자산 탭 '저축 · 투자 현황' 섹션.
final savingsCategoryBreakdownProvider =
    Provider<List<SavingsCategoryAmount>>((ref) {
  final all = ref.watch(expenseProvider);
  final categories = ref.watch(savingsCategoriesProvider);
  final categoryMap = {for (final c in categories) c.id: c};

  final totals = <String, double>{};
  for (final e in all.where((e) => e.isSavings)) {
    totals.update(e.categoryId, (v) => v + e.amount, ifAbsent: () => e.amount);
  }
  final total = totals.values.fold(0.0, (a, b) => a + b);

  final result = totals.entries
      .where((entry) => categoryMap.containsKey(entry.key))
      .map((entry) => SavingsCategoryAmount(
            category: categoryMap[entry.key]!,
            amount: entry.value,
            percent: total <= 0 ? 0 : entry.value / total,
          ))
      .toList()
    ..sort((a, b) => b.amount.compareTo(a.amount));
  return result;
});

/// 지금까지 기록된 모든 저축/투자 누적 합.
final totalSavingsProvider = Provider<double>((ref) {
  final breakdown = ref.watch(savingsCategoryBreakdownProvider);
  return breakdown.fold(0.0, (sum, item) => sum + item.amount);
});

/// 이번 달에 실행한 저축/투자 합계 — '저축 · 투자 현황' 섹션 상단 요약.
final totalSavingsThisMonthProvider = Provider<double>((ref) {
  final all = ref.watch(expenseProvider);
  final range = currentMonthRange();
  return all
      .where((e) => e.isSavings && range.contains(e.date))
      .fold(0.0, (sum, e) => sum + e.amount);
});
