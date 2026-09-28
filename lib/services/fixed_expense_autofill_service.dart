import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../data/local/hive_service.dart';
import '../data/models/expense.dart';
import '../providers/expense_provider.dart';
import '../providers/savings_planner_provider.dart';

const _watermarkKey = 'fixedExpenseAutoFillWatermarkMonth';

/// 장기 저축 플랜에 등록된 고정지출(월세, 통신비 등)을 매월 1일 자로 캘린더/지출
/// 내역에 자동 기입한다. 한 달에 한 번만 채우도록 "마지막으로 채운 월" 워터마크를
/// 저장해두고, 그 이후 달만 소급 생성한다(여러 달 건너뛰었다면 그만큼 모두 생성).
class FixedExpenseAutoFillService {
  FixedExpenseAutoFillService._();

  static Box get _settingsBox => Hive.box(HiveBoxes.settings);

  static String _monthKey(DateTime d) => DateFormat('yyyyMM').format(d);

  static Future<void> checkAndFillCurrentMonth(Ref ref, {DateTime? now}) async {
    final plan = ref.read(savingsPlanProvider);
    final items =
        plan.fixedExpenses.where((e) => e.amount > 0 && e.enabled).toList();
    if (items.isEmpty) return;

    now ??= DateTime.now();
    final lastFilled = _settingsBox.get(_watermarkKey) as String?;
    // 처음 켜는 것이라면 지금 이 달부터 채우고, 과거 달은 소급 생성하지 않는다
    // (JuiceSavingService.checkAndClosePeriods와 동일한 원칙).
    var cursor = lastFilled == null
        ? DateTime(now.year, now.month, 1)
        : DateTime(int.parse(lastFilled.substring(0, 4)),
            int.parse(lastFilled.substring(4, 6)) + 1, 1);

    final notifier = ref.read(expenseProvider.notifier);
    while (!cursor.isAfter(DateTime(now.year, now.month, 1))) {
      for (final item in items) {
        await notifier.upsert(Expense(
          id: const Uuid().v4(),
          amount: item.amount,
          categoryId: 'life',
          date: cursor,
          memo: item.name,
          isFixed: true,
        ));
      }
      cursor = DateTime(cursor.year, cursor.month + 1, 1);
    }
    await _settingsBox.put(_watermarkKey, _monthKey(now));
  }
}
