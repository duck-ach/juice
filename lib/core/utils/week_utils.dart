import '../../data/models/budget_period.dart';
import '../../data/models/week_start_day.dart';

class DateRange {
  const DateRange(this.start, this.end);

  final DateTime start;
  final DateTime end;

  bool contains(DateTime date) => !date.isBefore(start) && !date.isAfter(end);
}

/// [startDay] 기준으로 한 주의 시작일(00:00:00.000)과 마지막 시점을 계산.
DateRange currentWeekRange(
    [DateTime? now, WeekStartDay startDay = WeekStartDay.monday]) {
  final date = now ?? DateTime.now();
  final normalized = DateTime(date.year, date.month, date.day);
  // DateTime.weekday: 월=1 ... 일=7. 월요일 시작은 weekday-1, 일요일 시작은 weekday%7 만큼 앞으로 당긴다.
  final offset = startDay == WeekStartDay.monday
      ? normalized.weekday - 1
      : normalized.weekday % 7;
  final start = normalized.subtract(Duration(days: offset));
  final end = start
      .add(const Duration(days: 7))
      .subtract(const Duration(microseconds: 1));
  return DateRange(start, end);
}

/// [year]년 [month]월 1일 00:00:00.000 ~ 말일 23:59:59.999.
DateRange monthRange(int year, int month) {
  final start = DateTime(year, month, 1);
  final end =
      DateTime(year, month + 1, 1).subtract(const Duration(microseconds: 1));
  return DateRange(start, end);
}

/// 이번 달 1일 00:00:00.000 ~ 말일 23:59:59.999.
DateRange currentMonthRange([DateTime? now]) {
  final date = now ?? DateTime.now();
  return monthRange(date.year, date.month);
}

/// 시각을 제거한 날짜만 남긴 DateTime. Map 키 등 날짜 단위 비교/그룹핑에 사용.
DateTime dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

/// 오늘 00:00:00.000 ~ 23:59:59.999.
DateRange currentDayRange([DateTime? now]) {
  final date = now ?? DateTime.now();
  final start = dateOnly(date);
  return DateRange(
      start,
      start
          .add(const Duration(days: 1))
          .subtract(const Duration(microseconds: 1)));
}

/// 목표 주기(일/주/월)에 해당하는 현재 날짜 범위.
DateRange rangeForPeriod(BudgetPeriod period,
    [DateTime? now, WeekStartDay weekStartDay = WeekStartDay.monday]) {
  return switch (period) {
    BudgetPeriod.daily => currentDayRange(now),
    BudgetPeriod.weekly => currentWeekRange(now, weekStartDay),
    BudgetPeriod.monthly => currentMonthRange(now),
  };
}

/// [current] 바로 이전 주기(일/주/월) 범위. 주기 마감 히스토리를 과거로 거슬러 올라가며
/// 생성할 때(예: [JuiceSavingHistory]) 사용.
DateRange previousPeriodRange(BudgetPeriod period, DateRange current,
    [WeekStartDay weekStartDay = WeekStartDay.monday]) {
  return switch (period) {
    BudgetPeriod.daily =>
      currentDayRange(current.start.subtract(const Duration(days: 1))),
    BudgetPeriod.weekly =>
      currentWeekRange(current.start.subtract(const Duration(days: 1)), weekStartDay),
    BudgetPeriod.monthly => monthRange(
        current.start.month == 1 ? current.start.year - 1 : current.start.year,
        current.start.month == 1 ? 12 : current.start.month - 1),
  };
}

/// 오늘이 포함된 주를 포함해 최근 4주(설정된 주 시작 요일 기준) 범위.
DateRange last4WeeksRange(
    [DateTime? now, WeekStartDay startDay = WeekStartDay.monday]) {
  final thisWeek = currentWeekRange(now, startDay);
  final start = thisWeek.start.subtract(const Duration(days: 21));
  return DateRange(start, thisWeek.end);
}

/// 올해 1월 1일 ~ 12월 31일.
DateRange currentYearRange([DateTime? now]) {
  final date = now ?? DateTime.now();
  final start = DateTime(date.year, 1, 1);
  final end =
      DateTime(date.year + 1, 1, 1).subtract(const Duration(microseconds: 1));
  return DateRange(start, end);
}

/// [date]에서 [months]개월 후의 같은 날짜. 대상 월에 그 일자가 없으면(예: 1/31 + 1개월)
/// 대상 월의 말일로 보정한다. 할부 지출을 매달 같은 날로 자동 생성할 때 사용.
DateTime addMonthsClamped(DateTime date, int months) {
  final totalMonth = date.year * 12 + (date.month - 1) + months;
  final year = totalMonth ~/ 12;
  final month = totalMonth % 12 + 1;
  final daysInTargetMonth = DateTime(year, month + 1, 0).day;
  final day = date.day > daysInTargetMonth ? daysInTargetMonth : date.day;
  return DateTime(year, month, day);
}

/// 올해를 포함해 최근 [n]년 범위(1월 1일 ~ 12월 31일).
DateRange lastNYearsRange(int n, [DateTime? now]) {
  final date = now ?? DateTime.now();
  final start = DateTime(date.year - n + 1, 1, 1);
  final end =
      DateTime(date.year + 1, 1, 1).subtract(const Duration(microseconds: 1));
  return DateRange(start, end);
}
