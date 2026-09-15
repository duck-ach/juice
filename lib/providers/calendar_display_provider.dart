import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';

import '../core/utils/compact_currency_formatter.dart';
import '../data/local/hive_service.dart';

const _displayModeKey = 'calendarAmountDisplayMode';

/// 캘린더 날짜 셀 금액 표시 방식(축약형/확장형). budgetPeriod 등과 같은 방식으로 Hive
/// `settings` 박스에 영구 저장된다.
class CalendarAmountDisplayModeNotifier
    extends Notifier<CalendarAmountDisplayMode> {
  Box get _box => Hive.box(HiveBoxes.settings);

  @override
  CalendarAmountDisplayMode build() {
    final stored = _box.get(_displayModeKey) as String?;
    return CalendarAmountDisplayMode.values.firstWhere(
      (m) => m.name == stored,
      orElse: () => CalendarAmountDisplayMode.compact,
    );
  }

  Future<void> toggle() async {
    final next = state == CalendarAmountDisplayMode.compact
        ? CalendarAmountDisplayMode.full
        : CalendarAmountDisplayMode.compact;
    await _box.put(_displayModeKey, next.name);
    state = next;
  }
}

final calendarAmountDisplayModeProvider = NotifierProvider<
    CalendarAmountDisplayModeNotifier, CalendarAmountDisplayMode>(
  CalendarAmountDisplayModeNotifier.new,
);

/// 캘린더 월/주 접기·펼치기 상태. 설정이 아닌 화면 UI 상태라 저장하지 않고, 화면을
/// 벗어나면(다음 진입 시) 항상 월간 뷰로 되돌아간다.
final calendarFormatProvider =
    StateProvider<CalendarFormat>((ref) => CalendarFormat.month);
