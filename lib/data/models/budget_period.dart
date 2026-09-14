import '../../l10n/app_localizations.dart';

/// 목표(주스) 추적 주기.
enum BudgetPeriod { daily, weekly, monthly }

extension BudgetPeriodLabel on BudgetPeriod {
  /// "이번 주 남은 주스"처럼 대시보드/위젯에서 기간을 가리키는 접두어.
  String label(AppLocalizations loc) => switch (this) {
        BudgetPeriod.daily => loc.periodDaily,
        BudgetPeriod.weekly => loc.periodWeekly,
        BudgetPeriod.monthly => loc.periodMonthly,
      };

  /// 설정 화면의 주기 선택 버튼 라벨.
  String settingLabel(AppLocalizations loc) => switch (this) {
        BudgetPeriod.daily => loc.periodSettingDaily,
        BudgetPeriod.weekly => loc.periodSettingWeekly,
        BudgetPeriod.monthly => loc.periodSettingMonthly,
      };
}
