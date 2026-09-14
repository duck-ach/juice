import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../core/utils/week_utils.dart';
import '../data/local/hive_service.dart';
import '../data/models/budget_period.dart';
import '../data/models/juice_saving_history.dart';
import '../providers/budget_settings_provider.dart';
import '../providers/juice_theme_provider.dart';

/// 목표 주기(일/주/월) 마감을 감지해 [JuiceSavingHistory] 레코드를 만든다.
/// spentAmount/savedAmount는 저장하지 않고(항상 최신 지출로 동적 계산) 주기 경계와
/// 마감 당시의 목표량/테마 이모지만 스냅샷으로 남기므로, 과거 지출을 뒤늦게 넣거나
/// 목표 금액을 바꿔도 이미 만들어진 히스토리 레코드 자체는 다시 손댈 필요가 없다.
class JuiceSavingService {
  JuiceSavingService._();

  static Box<JuiceSavingHistory> get _box =>
      Hive.box<JuiceSavingHistory>(HiveBoxes.juiceSavingHistory);

  static List<JuiceSavingHistory> getAll() => _box.values.toList();

  static String _idFor(BudgetPeriod period, DateTime start) =>
      '${period.name}_${DateFormat('yyyyMMdd').format(start)}';

  static String _watermarkKey(BudgetPeriod period) =>
      'juiceSavingWatermarkStart_${period.name}';

  /// 현재 활성 주기([budgetPeriodProvider])에 한해, 마지막으로 확인했을 때 "현재 진행 중"이던
  /// 주기의 시작 시각을 설정 박스에 워터마크로 저장해두고, 다음 호출에서 그 워터마크부터
  /// 지금 직전까지 완전히 지나간 주기를 모두 히스토리로 저장한다(여러 날 건너뛰었다면 그만큼
  /// 소급 생성). 목표 금액이 설정되어 있지 않으면(null) 정산할 대상이 없으므로 아무 것도
  /// 하지 않는다. 이 주기 유형을 처음 확인하는 것이라면(워터마크 없음) 지금 이 순간을
  /// 기준선으로만 삼고 과거를 소급 생성하지 않는다.
  static Future<void> checkAndClosePeriods(Ref ref, {DateTime? now}) async {
    final period = ref.read(budgetPeriodProvider);
    final weekStartDay = ref.read(weekStartDayProvider);
    final target = ref.read(periodTargetAmountsProvider).forPeriod(period);
    if (target == null) return;

    final theme = ref.read(resolvedJuiceThemeProvider);
    now ??= DateTime.now();
    final range = rangeForPeriod(period, now, weekStartDay);

    final settingsBox = Hive.box(HiveBoxes.settings);
    final watermarkKey = _watermarkKey(period);
    final storedStart = settingsBox.get(watermarkKey) as DateTime?;

    if (storedStart == null || !storedStart.isBefore(range.start)) {
      // 처음 확인하거나(워터마크 없음), 워터마크가 가리키던 주기가 아직도 "현재 진행 중"인
      // 경우(같은 주기 안) — 마감할 게 없으니 현재 주기 시작으로 기준선만 맞춰둔다.
      await settingsBox.put(watermarkKey, range.start);
      return;
    }

    // storedStart(그때의 "현재 주기" 시작)부터 지금 이전까지, 완전히 지나간 주기를 최근
    // 것부터 거슬러 올라가며 모두 마감 처리한다.
    var cursor = previousPeriodRange(period, range, weekStartDay);
    while (!cursor.start.isBefore(storedStart)) {
      final id = _idFor(period, cursor.start);
      if (!_box.containsKey(id)) {
        await _box.put(
          id,
          JuiceSavingHistory(
            id: id,
            periodType: period.name,
            startDate: cursor.start,
            endDate: cursor.end,
            targetAmount: target,
            themeEmoji: theme.emoji,
          ),
        );
      }
      if (!cursor.start.isAfter(storedStart)) break;
      cursor = previousPeriodRange(period, cursor, weekStartDay);
    }
    await settingsBox.put(watermarkKey, range.start);
  }
}
