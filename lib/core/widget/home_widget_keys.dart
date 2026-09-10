/// 홈 위젯(SharedPreferences / UserDefaults)에 저장되는 키.
/// 네이티브(Android RemoteViews, iOS WidgetKit) 쪽 코드와 반드시 동일한 문자열을 사용해야 한다.
class HomeWidgetKeys {
  HomeWidgetKeys._();

  static const remainingText = 'remaining_text';
  static const budgetText = 'budget_text';
  static const percent = 'percent';
  static const weekLabel = 'week_label';
}

/// 위젯 프로바이더/킨드 식별자.
class HomeWidgetNames {
  HomeWidgetNames._();

  static const androidGaugeProvider = 'JuiceGaugeWidgetProvider';
  static const androidQuickAddProvider = 'JuiceQuickAddWidgetProvider';

  /// iOS WidgetKit 익스텐션에서 사용할 kind 문자열 (익스텐션 추가 시 동일하게 맞출 것).
  static const iosGaugeWidget = 'JuiceGaugeWidget';
}

/// 위젯 탭 시 앱을 여는 딥링크.
/// URI의 scheme/host는 파싱 과정에서 소문자로 정규화되므로 소문자로 정의한다.
class HomeWidgetDeepLinks {
  HomeWidgetDeepLinks._();

  static const addExpenseHost = 'addexpense';
}
