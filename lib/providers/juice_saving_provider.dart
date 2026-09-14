import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/juice_saving_history.dart';
import '../services/juice_saving_service.dart';
import 'expense_provider.dart';

/// 앱 세션당 한 번, 화면이 이 값을 읽는 시점에 [JuiceSavingService.checkAndClosePeriods]를
/// 실행한다("화면 진입 시" 마감 감지). FutureProvider는 결과를 캐시하므로 이후 리빌드에서
/// 다시 실행되지 않는다.
final juiceSavingCheckProvider = FutureProvider<void>((ref) async {
  await JuiceSavingService.checkAndClosePeriods(ref);
});

/// 마감된 모든 주기 히스토리. [juiceSavingCheckProvider]가 끝난 뒤 최신 Hive 데이터를 읽는다.
final juiceSavingHistoryProvider = Provider<List<JuiceSavingHistory>>((ref) {
  ref.watch(juiceSavingCheckProvider);
  return JuiceSavingService.getAll();
});

/// 히스토리 한 건 + 그 시점 기준 실시간 소비/절약 계산 결과를 함께 묶은 뷰모델.
class JuiceSavingRecord {
  const JuiceSavingRecord({
    required this.history,
    required this.spent,
    required this.saved,
    required this.isSuccess,
  });

  final JuiceSavingHistory history;
  final double spent;
  final double saved;
  final bool isSuccess;
}

/// 최신 마감분부터 정렬된 절약 기록 목록. [expenseProvider]를 직접 watch하므로 과거 지출을
/// 추가/수정/삭제하는 즉시(날짜에 상관없이) 모든 레코드의 spent/saved가 다시 계산된다.
final juiceSavingRecordsProvider = Provider<List<JuiceSavingRecord>>((ref) {
  final history = ref.watch(juiceSavingHistoryProvider);
  final allExpenses = ref.watch(expenseProvider);
  final records = history
      .map((h) => JuiceSavingRecord(
            history: h,
            spent: h.spentAmount(allExpenses),
            saved: h.savedAmount(allExpenses),
            isSuccess: h.isSuccess(allExpenses),
          ))
      .toList()
    ..sort((a, b) => b.history.endDate.compareTo(a.history.endDate));
  return records;
});

/// 지금까지 마감된 모든 "성공"(목표 초과하지 않은) 주기의 savedAmount 총합.
final totalSavedJuiceProvider = Provider<double>((ref) {
  final records = ref.watch(juiceSavingRecordsProvider);
  return records
      .where((r) => r.isSuccess)
      .fold(0.0, (sum, r) => sum + r.saved);
});
