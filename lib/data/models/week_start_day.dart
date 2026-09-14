import '../../l10n/app_localizations.dart';

/// 일주일의 시작 요일 기준. 홈 화면 '이번 주' 계산과 캘린더 주차 계산에 함께 반영된다.
enum WeekStartDay { monday, sunday }

extension WeekStartDayLabel on WeekStartDay {
  String label(AppLocalizations loc) => switch (this) {
        WeekStartDay.monday => loc.weekStartMonday,
        WeekStartDay.sunday => loc.weekStartSunday,
      };
}
