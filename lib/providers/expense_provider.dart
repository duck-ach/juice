import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/week_utils.dart';
import '../data/models/expense.dart';
import '../data/repositories/expense_repository.dart';
import 'budget_settings_provider.dart';
import 'installment_settings_provider.dart';

final expenseRepositoryProvider =
    Provider<ExpenseRepository>((ref) => ExpenseRepository());

class ExpenseNotifier extends Notifier<List<Expense>> {
  @override
  List<Expense> build() => ref.read(expenseRepositoryProvider).getAll();

  /// 새 지출을 추가하거나(신규 id) 기존 지출을 수정한다(같은 id로 덮어쓰기).
  Future<void> upsert(Expense expense) async {
    final repo = ref.read(expenseRepositoryProvider);
    await repo.add(expense);
    state = repo.getAll();
  }

  /// 신용카드 할부 지출: [months]개월로 분할해 미래 기록까지 한 번에 생성한다.
  /// 반영 방식(익월 일괄/매일 분할)은 [installmentBillingModeProvider] 설정을 따른다.
  Future<void> upsertInstallment(Expense base, int months) async {
    final repo = ref.read(expenseRepositoryProvider);
    final mode = ref.read(installmentBillingModeProvider);
    await repo.addInstallment(base, months, mode);
    state = repo.getAll();
  }

  Future<void> delete(String id) async {
    final repo = ref.read(expenseRepositoryProvider);
    await repo.delete(id);
    state = repo.getAll();
  }
}

final expenseProvider =
    NotifierProvider<ExpenseNotifier, List<Expense>>(ExpenseNotifier.new);

/// 대시보드 내역 필터: 변동지출만 보기 vs 전체(고정지출 포함) 보기.
/// 주스 게이지 소진량 계산에는 영향을 주지 않음 — 고정지출은 항상 제외.
enum ExpenseFilter { variableOnly, all }

final expenseFilterProvider =
    StateProvider<ExpenseFilter>((ref) => ExpenseFilter.variableOnly);

final currentWeekExpensesProvider = Provider<List<Expense>>((ref) {
  final all = ref.watch(expenseProvider);
  final weekStartDay = ref.watch(weekStartDayProvider);
  final range = currentWeekRange(null, weekStartDay);
  final weekExpenses = all
      .where((e) => !e.isIncome && range.contains(e.date))
      .toList()
    ..sort((a, b) => b.date.compareTo(a.date));
  return weekExpenses;
});

/// 이번 주 변동지출 합계 (고정지출 제외) — 주스 게이지가 참조하는 값.
final weeklySpentProvider = Provider<double>((ref) {
  final weekExpenses = ref.watch(currentWeekExpensesProvider);
  return weekExpenses
      .where((e) => !e.isFixed)
      .fold(0.0, (sum, e) => sum + e.amount);
});

/// 오늘 날짜에 잡힌 신용카드 할부 분할액 합계. [InstallmentBillingMode.dailyEven]일 때만
/// 매일 의미 있는 값이 생기고(익월 일괄 청구는 1일에만 값이 생김), 없으면 0.
final todayInstallmentPortionProvider = Provider<double>((ref) {
  final all = ref.watch(expenseProvider);
  final today = currentDayRange();
  return all
      .where((e) => e.isInstallment && today.contains(e.date))
      .fold(0.0, (sum, e) => sum + e.amount);
});
