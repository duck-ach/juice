import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/expense.dart';
import 'expense_provider.dart';

enum AssetPeriod { monthly, yearly }

extension AssetPeriodLabel on AssetPeriod {
  String get label => switch (this) {
        AssetPeriod.monthly => '월별',
        AssetPeriod.yearly => '연도별',
      };
}

final assetPeriodProvider =
    StateProvider<AssetPeriod>((ref) => AssetPeriod.monthly);

class AssetPoint {
  const AssetPoint(
      {required this.label, required this.income, required this.expense});

  final String label;
  final double income;
  final double expense;

  double get net => income - expense;
}

/// 지금까지 기록된 모든 수입-지출 누적 합 — '순자산' 요약 카드에 사용.
final cumulativeNetWorthProvider = Provider<double>((ref) {
  final all = ref.watch(expenseProvider);
  return all.fold(0.0, (sum, e) => sum + (e.isIncome ? e.amount : -e.amount));
});

/// 월별(올해 1~12월) / 연도별(최근 5년) 수입·지출·순증감 추이.
final assetTrendProvider = Provider<List<AssetPoint>>((ref) {
  final period = ref.watch(assetPeriodProvider);
  final all = ref.watch(expenseProvider);

  AssetPoint pointFor(String label, Iterable<Expense> items) {
    final income =
        items.where((e) => e.isIncome).fold(0.0, (s, e) => s + e.amount);
    final expense =
        items.where((e) => !e.isIncome).fold(0.0, (s, e) => s + e.amount);
    return AssetPoint(label: label, income: income, expense: expense);
  }

  if (period == AssetPeriod.monthly) {
    final year = DateTime.now().year;
    return List.generate(12, (i) {
      final month = i + 1;
      final items =
          all.where((e) => e.date.year == year && e.date.month == month);
      return pointFor('$month월', items);
    });
  }

  final currentYear = DateTime.now().year;
  return List.generate(5, (i) {
    final year = currentYear - 4 + i;
    final items = all.where((e) => e.date.year == year);
    return pointFor('$year', items);
  });
});
