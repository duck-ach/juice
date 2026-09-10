import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/week_utils.dart';
import '../data/models/expense.dart';
import '../data/repositories/expense_repository.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) => ExpenseRepository());

class ExpenseNotifier extends Notifier<List<Expense>> {
  @override
  List<Expense> build() => ref.read(expenseRepositoryProvider).getAll();

  /// 새 지출을 추가하거나(신규 id) 기존 지출을 수정한다(같은 id로 덮어쓰기).
  Future<void> upsert(Expense expense) async {
    final repo = ref.read(expenseRepositoryProvider);
    await repo.add(expense);
    state = repo.getAll();
  }

  Future<void> delete(String id) async {
    final repo = ref.read(expenseRepositoryProvider);
    await repo.delete(id);
    state = repo.getAll();
  }
}

final expenseProvider = NotifierProvider<ExpenseNotifier, List<Expense>>(ExpenseNotifier.new);

/// 대시보드 내역 필터: 변동지출만 보기 vs 전체(고정지출 포함) 보기.
/// 주스 게이지 소진량 계산에는 영향을 주지 않음 — 고정지출은 항상 제외.
enum ExpenseFilter { variableOnly, all }

final expenseFilterProvider = StateProvider<ExpenseFilter>((ref) => ExpenseFilter.variableOnly);

final currentWeekExpensesProvider = Provider<List<Expense>>((ref) {
  final all = ref.watch(expenseProvider);
  final range = currentWeekRange();
  final weekExpenses = all.where((e) => range.contains(e.date)).toList()
    ..sort((a, b) => b.date.compareTo(a.date));
  return weekExpenses;
});

/// 이번 주 변동지출 합계 (고정지출 제외) — 주스 게이지가 참조하는 값.
final weeklySpentProvider = Provider<double>((ref) {
  final weekExpenses = ref.watch(currentWeekExpensesProvider);
  return weekExpenses.where((e) => !e.isFixed).fold(0.0, (sum, e) => sum + e.amount);
});
