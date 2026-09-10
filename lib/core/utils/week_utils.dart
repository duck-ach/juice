import '../../data/models/budget_period.dart';

class DateRange {
  const DateRange(this.start, this.end);

  final DateTime start;
  final DateTime end;

  bool contains(DateTime date) => !date.isBefore(start) && !date.isAfter(end);
}

/// 월요일을 기준으로 한 주의 시작일(00:00:00.000)과 마지막 시점을 계산.
DateRange currentWeekRange([DateTime? now]) {
  final date = now ?? DateTime.now();
  final normalized = DateTime(date.year, date.month, date.day);
  final start = normalized.subtract(Duration(days: normalized.weekday - 1));
  final end = start.add(const Duration(days: 7)).subtract(const Duration(microseconds: 1));
  return DateRange(start, end);
}

/// [year]년 [month]월 1일 00:00:00.000 ~ 말일 23:59:59.999.
DateRange monthRange(int year, int month) {
  final start = DateTime(year, month, 1);
  final end = DateTime(year, month + 1, 1).subtract(const Duration(microseconds: 1));
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
  return DateRange(start, start.add(const Duration(days: 1)).subtract(const Duration(microseconds: 1)));
}

/// 목표 주기(일/주/월)에 해당하는 현재 날짜 범위.
DateRange rangeForPeriod(BudgetPeriod period, [DateTime? now]) {
  return switch (period) {
    BudgetPeriod.daily => currentDayRange(now),
    BudgetPeriod.weekly => currentWeekRange(now),
    BudgetPeriod.monthly => currentMonthRange(now),
  };
}

/// 오늘이 포함된 주를 포함해 최근 4주(월요일 기준) 범위.
DateRange last4WeeksRange([DateTime? now]) {
  final thisWeek = currentWeekRange(now);
  final start = thisWeek.start.subtract(const Duration(days: 21));
  return DateRange(start, thisWeek.end);
}

/// 올해 1월 1일 ~ 12월 31일.
DateRange currentYearRange([DateTime? now]) {
  final date = now ?? DateTime.now();
  final start = DateTime(date.year, 1, 1);
  final end = DateTime(date.year + 1, 1, 1).subtract(const Duration(microseconds: 1));
  return DateRange(start, end);
}

/// 올해를 포함해 최근 [n]년 범위(1월 1일 ~ 12월 31일).
DateRange lastNYearsRange(int n, [DateTime? now]) {
  final date = now ?? DateTime.now();
  final start = DateTime(date.year - n + 1, 1, 1);
  final end = DateTime(date.year + 1, 1, 1).subtract(const Duration(microseconds: 1));
  return DateRange(start, end);
}
