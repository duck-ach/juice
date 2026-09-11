import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';

const _installmentBillingModeKey = 'installmentBillingMode';

/// 신용카드 할부를 캘린더/예산에 반영하는 방식.
enum InstallmentBillingMode {
  /// 이번 달 결제일과 무관하게, 회차별 분할 금액을 익월 1일부터 매월 1일에 한 번에 반영.
  monthlyLumpNextMonth,

  /// 회차별 분할 금액을 해당 청구월의 일수만큼 다시 나눠 매일 조금씩 반영.
  dailyEven,
}

extension InstallmentBillingModeLabel on InstallmentBillingMode {
  String get label => switch (this) {
        InstallmentBillingMode.monthlyLumpNextMonth => '익월 1일 일괄 청구',
        InstallmentBillingMode.dailyEven => '매일 균등 분할 청구',
      };

  String get description => switch (this) {
        InstallmentBillingMode.monthlyLumpNextMonth =>
          '실제 카드 대금처럼, 할부 회차 금액이 매월 1일에 한 번에 지출로 잡혀요.',
        InstallmentBillingMode.dailyEven =>
          '그 달의 할부 회차 금액을 일수만큼 나눠 매일 조금씩 주스 게이지에서 빠져나가요.',
      };
}

/// 신용카드 할부 반영 방식 설정. 기본값은 [InstallmentBillingMode.dailyEven](강력 추천).
class InstallmentBillingModeNotifier extends Notifier<InstallmentBillingMode> {
  @override
  InstallmentBillingMode build() {
    final stored =
        Hive.box(HiveBoxes.settings).get(_installmentBillingModeKey) as String?;
    return InstallmentBillingMode.values.firstWhere(
      (m) => m.name == stored,
      orElse: () => InstallmentBillingMode.dailyEven,
    );
  }

  Future<void> setMode(InstallmentBillingMode mode) async {
    await Hive.box(HiveBoxes.settings)
        .put(_installmentBillingModeKey, mode.name);
    state = mode;
  }
}

final installmentBillingModeProvider =
    NotifierProvider<InstallmentBillingModeNotifier, InstallmentBillingMode>(
        InstallmentBillingModeNotifier.new);
