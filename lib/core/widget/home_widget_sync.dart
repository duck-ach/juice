import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/budget_settings_provider.dart';
import '../../providers/home_widget_settings_provider.dart';
import '../../providers/period_budget_provider.dart';
import 'home_widget_service.dart';

/// 목표/지출/주기/가리기 설정이 바뀔 때마다 홈 위젯 데이터를 동기화하는 비가시 래퍼.
class HomeWidgetSync extends ConsumerWidget {
  const HomeWidgetSync({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(targetAmountProvider, (_, __) => _sync(ref));
    ref.listen(periodSpentProvider, (_, __) => _sync(ref));
    ref.listen(budgetPeriodProvider, (_, __) => _sync(ref));
    ref.listen(hideWidgetAmountProvider, (_, __) => _sync(ref));

    // 최초 빌드 시 한 번 동기화 (앱 시작 시점 위젯 데이터 반영).
    _sync(ref);

    return child;
  }

  void _sync(WidgetRef ref) {
    HomeWidgetService.updateGauge(
      targetAmount: ref.read(targetAmountProvider),
      spent: ref.read(periodSpentProvider),
      hideAmount: ref.read(hideWidgetAmountProvider),
      period: ref.read(budgetPeriodProvider),
      range: ref.read(currentBudgetRangeProvider),
    );
  }
}
