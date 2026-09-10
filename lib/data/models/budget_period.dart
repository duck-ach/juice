/// 목표(주스) 추적 주기.
enum BudgetPeriod { daily, weekly, monthly }

extension BudgetPeriodLabel on BudgetPeriod {
  /// "이번 주 남은 주스"처럼 대시보드/위젯에서 기간을 가리키는 접두어.
  String get label => switch (this) {
        BudgetPeriod.daily => '오늘',
        BudgetPeriod.weekly => '이번 주',
        BudgetPeriod.monthly => '이번 달',
      };

  /// 설정 화면의 주기 선택 버튼 라벨.
  String get settingLabel => switch (this) {
        BudgetPeriod.daily => '일간',
        BudgetPeriod.weekly => '주간',
        BudgetPeriod.monthly => '월간',
      };
}
