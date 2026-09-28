import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';
import '../services/fixed_expense_autofill_service.dart';

const _autoFillEnabledKey = 'calendarAutoFillFixedExpenses';

/// 고정지출(월세, 통신비 등) 캘린더 자동 기입 ON/OFF. 기본값 OFF — 유저가 명시적으로
/// 켜야만 매월 자동으로 캘린더/지출 내역에 기입된다.
class FixedExpenseAutoFillNotifier extends Notifier<bool> {
  Box get _box => Hive.box(HiveBoxes.settings);

  @override
  bool build() => _box.get(_autoFillEnabledKey) as bool? ?? false;

  Future<void> setEnabled(bool enabled) async {
    await _box.put(_autoFillEnabledKey, enabled);
    state = enabled;
  }
}

final fixedExpenseAutoFillEnabledProvider =
    NotifierProvider<FixedExpenseAutoFillNotifier, bool>(
        FixedExpenseAutoFillNotifier.new);

/// 화면 진입 시(주로 캘린더/홈) 한 번 이번 달 고정지출이 이미 자동 기입됐는지 확인하고,
/// 안 됐다면 채워 넣는다. [juiceSavingCheckProvider]와 동일하게 FutureProvider 캐시를
/// 이용한 "세션당 1회 체크" 패턴.
final fixedExpenseAutoFillCheckProvider = FutureProvider<void>((ref) async {
  final enabled = ref.watch(fixedExpenseAutoFillEnabledProvider);
  if (!enabled) return;
  await FixedExpenseAutoFillService.checkAndFillCurrentMonth(ref);
});
