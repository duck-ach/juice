import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';

import '../core/utils/compact_currency_formatter.dart';
import '../data/local/hive_service.dart';
import '../data/models/week_start_day.dart';

const _displayModeKey = 'calendarAmountDisplayMode';
const _calendarStartDayKey = 'calendarStartDay';
const _showNoSpendStampKey = 'calendarShowNoSpendStamp';
const _highlightWeekendKey = 'calendarHighlightWeekend';

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
    await setMode(next);
  }

  Future<void> setMode(CalendarAmountDisplayMode mode) async {
    await _box.put(_displayModeKey, mode.name);
    state = mode;
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

/// 캘린더 그리드 표시 전용 시작 요일. 홈 대시보드/예산 정산이 쓰는
/// [weekStartDayProvider](budget_settings_provider.dart)와는 완전히 독립적인 별도
/// 설정이다 — 예산은 월~일로 정산하면서 캘린더는 일~토로 보고 싶은 경우를 지원한다.
class CalendarStartDayNotifier extends Notifier<WeekStartDay> {
  Box get _box => Hive.box(HiveBoxes.settings);

  @override
  WeekStartDay build() {
    final stored = _box.get(_calendarStartDayKey) as String?;
    return WeekStartDay.values.firstWhere(
      (d) => d.name == stored,
      orElse: () => WeekStartDay.monday,
    );
  }

  Future<void> setDay(WeekStartDay day) async {
    await _box.put(_calendarStartDayKey, day.name);
    state = day;
  }
}

final calendarStartDayProvider =
    NotifierProvider<CalendarStartDayNotifier, WeekStartDay>(
        CalendarStartDayNotifier.new);

/// 지출이 없는 날에 주스 테마 과일 이모지 스탬프를 표시할지. 기본값 ON.
class CalendarShowNoSpendStampNotifier extends Notifier<bool> {
  Box get _box => Hive.box(HiveBoxes.settings);

  @override
  bool build() => _box.get(_showNoSpendStampKey) as bool? ?? true;

  Future<void> setEnabled(bool enabled) async {
    await _box.put(_showNoSpendStampKey, enabled);
    state = enabled;
  }
}

final calendarShowNoSpendStampProvider =
    NotifierProvider<CalendarShowNoSpendStampNotifier, bool>(
        CalendarShowNoSpendStampNotifier.new);

/// 토요일(파랑)/일요일(빨강) 날짜 숫자 색상 강조 여부. 기본값 OFF(선택적 강조 옵션).
class CalendarHighlightWeekendNotifier extends Notifier<bool> {
  Box get _box => Hive.box(HiveBoxes.settings);

  @override
  bool build() => _box.get(_highlightWeekendKey) as bool? ?? false;

  Future<void> setEnabled(bool enabled) async {
    await _box.put(_highlightWeekendKey, enabled);
    state = enabled;
  }
}

final calendarHighlightWeekendProvider =
    NotifierProvider<CalendarHighlightWeekendNotifier, bool>(
        CalendarHighlightWeekendNotifier.new);
