import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';

const _hideAmountKey = 'widgetHideAmount';

/// 홈 위젯에서 금액을 가리고 잔여 % 수위만 노출할지 여부.
class HideWidgetAmountNotifier extends Notifier<bool> {
  @override
  bool build() =>
      (Hive.box(HiveBoxes.settings).get(_hideAmountKey) as bool?) ?? false;

  Future<void> setHidden(bool value) async {
    await Hive.box(HiveBoxes.settings).put(_hideAmountKey, value);
    state = value;
  }
}

final hideWidgetAmountProvider =
    NotifierProvider<HideWidgetAmountNotifier, bool>(
  HideWidgetAmountNotifier.new,
);
