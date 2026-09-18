import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/expense.dart';
import 'expense_provider.dart';
import 'stats_provider.dart';

/// 카테고리 상세 화면: 이 카테고리로 기록된 전체 내역(최신순). 지출/수입/저축
/// 어느 쪽 카테고리든 공용으로 쓴다.
final categoryDetailExpensesProvider =
    Provider.family<List<Expense>, String>((ref, categoryId) {
  final all = ref.watch(expenseProvider);
  return all.where((e) => e.categoryId == categoryId).toList()
    ..sort((a, b) => b.date.compareTo(a.date));
});

/// 카테고리 상세 화면: 이번 달 이 카테고리 합계.
final categoryDetailThisMonthTotalProvider =
    Provider.family<double, String>((ref, categoryId) {
  final now = DateTime.now();
  return ref.watch(categoryDetailExpensesProvider(categoryId)).where((e) =>
      e.date.year == now.year && e.date.month == now.month)
      .fold(0.0, (sum, e) => sum + e.amount);
});

/// 카테고리 상세 화면: 최근 6개월(이번 달 포함) 월별 합계 추이.
final categoryDetailMonthlyTrendProvider =
    Provider.family<List<TrendPoint>, String>((ref, categoryId) {
  final expenses = ref.watch(categoryDetailExpensesProvider(categoryId));
  final now = DateTime.now();
  return List.generate(6, (i) {
    final monthDate = DateTime(now.year, now.month - 5 + i, 1);
    final amount = expenses
        .where((e) =>
            e.date.year == monthDate.year && e.date.month == monthDate.month)
        .fold(0.0, (sum, e) => sum + e.amount);
    return TrendPoint(periodValue: monthDate.month, amount: amount);
  });
});
