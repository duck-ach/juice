import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/expense.dart';
import 'expense_provider.dart';
import 'stats_provider.dart';

/// 법인/업무용 카드 상세 화면: 전체 법인카드 지출(최신순). 개인 지출 통계와는 완전히
/// 분리된, 영수증 보관용 기록이다.
final corporateExpensesProvider = Provider<List<Expense>>((ref) {
  final all = ref.watch(expenseProvider);
  return all.where((e) => e.isCorporate).toList()
    ..sort((a, b) => b.date.compareTo(a.date));
});

/// 법인/업무용 카드 상세 화면: 이번 달 합계.
final corporateThisMonthTotalProvider = Provider<double>((ref) {
  final now = DateTime.now();
  return ref
      .watch(corporateExpensesProvider)
      .where((e) => e.date.year == now.year && e.date.month == now.month)
      .fold(0.0, (sum, e) => sum + e.amount);
});

/// 법인/업무용 카드 상세 화면: 최근 6개월(이번 달 포함) 월별 합계 추이.
final corporateMonthlyTrendProvider = Provider<List<TrendPoint>>((ref) {
  final expenses = ref.watch(corporateExpensesProvider);
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
