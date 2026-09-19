import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/expense.dart';
import 'expense_provider.dart';
import 'stats_provider.dart';

/// 카드 상세 화면: 이 카드(cardId)로 기록된 전체 지출(최신순). 신용카드 할부로 분할된
/// 레코드는 각자의 청구일에 이미 이 카드로 집계되어 있으므로 그대로 포함된다.
final cardDetailExpensesProvider =
    Provider.family<List<Expense>, String>((ref, cardId) {
  final all = ref.watch(expenseProvider);
  return all.where((e) => e.cardId == cardId).toList()
    ..sort((a, b) => b.date.compareTo(a.date));
});

/// 카드 상세 화면: 이번 달 이 카드 합계.
final cardDetailThisMonthTotalProvider =
    Provider.family<double, String>((ref, cardId) {
  final now = DateTime.now();
  return ref
      .watch(cardDetailExpensesProvider(cardId))
      .where((e) => e.date.year == now.year && e.date.month == now.month)
      .fold(0.0, (sum, e) => sum + e.amount);
});

/// 카드 상세 화면: 최근 6개월(이번 달 포함) 월별 합계 추이.
final cardDetailMonthlyTrendProvider =
    Provider.family<List<TrendPoint>, String>((ref, cardId) {
  final expenses = ref.watch(cardDetailExpensesProvider(cardId));
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
