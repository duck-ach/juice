import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';

import '../../core/utils/week_utils.dart';
import '../../data/models/budget_period.dart';
import 'home_widget_keys.dart';

/// iOS 앱 그룹 ID. WidgetKit 익스텐션을 추가할 때 Xcode에서
/// 앱 타겟과 익스텐션 타겟 양쪽에 동일한 App Group을 등록해야 한다.
const iosAppGroupId = 'group.com.juiceapp.juice';

/// Flutter <-> 홈 화면 위젯 데이터 파이프라인.
/// 실제 위젯 UI(Android RemoteViews / iOS WidgetKit)는 이 키들을 읽어 그린다.
class HomeWidgetService {
  HomeWidgetService._();

  static Future<void> configure() async {
    await HomeWidget.setAppGroupId(iosAppGroupId);
  }

  static Future<void> updateGauge({
    required double? targetAmount,
    required double spent,
    required bool hideAmount,
    required BudgetPeriod period,
    required DateRange range,
  }) async {
    final formatter = NumberFormat('#,###');
    final total = targetAmount ?? 0;
    final remaining = (total - spent).clamp(0, total).toDouble();
    final percent = total <= 0 ? 0 : ((remaining / total) * 100).round().clamp(0, 100);

    await HomeWidget.saveWidgetData<String>(
      HomeWidgetKeys.remainingText,
      hideAmount ? '***mL' : '${formatter.format(remaining)} mL',
    );
    await HomeWidget.saveWidgetData<String>(
      HomeWidgetKeys.budgetText,
      hideAmount ? '***mL' : '${formatter.format(total)} mL',
    );
    await HomeWidget.saveWidgetData<int>(HomeWidgetKeys.percent, percent);
    await HomeWidget.saveWidgetData<String>(HomeWidgetKeys.weekLabel, _labelFor(period, range));

    await HomeWidget.updateWidget(
      androidName: HomeWidgetNames.androidGaugeProvider,
      iOSName: HomeWidgetNames.iosGaugeWidget,
    );
  }

  static String _labelFor(BudgetPeriod period, DateRange range) {
    return switch (period) {
      BudgetPeriod.daily => DateFormat('M.d (E)', 'ko').format(range.start),
      BudgetPeriod.weekly => '${DateFormat('M.d').format(range.start)} - ${DateFormat('M.d').format(range.end)}',
      BudgetPeriod.monthly => DateFormat('yyyy.M', 'ko').format(range.start),
    };
  }
}
