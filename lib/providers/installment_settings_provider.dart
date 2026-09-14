import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';
import '../l10n/app_localizations.dart';

const _installmentBillingModeKey = 'installmentBillingMode';

/// 신용카드 할부를 캘린더/예산에 반영하는 방식.
enum InstallmentBillingMode {
  /// 이번 달 결제일과 무관하게, 회차별 분할 금액을 익월 1일부터 매월 1일에 한 번에 반영.
  monthlyLumpNextMonth,

  /// 회차별 분할 금액을 해당 청구월의 일수만큼 다시 나눠 매일 조금씩 반영.
  dailyEven,
}

extension InstallmentBillingModeLabel on InstallmentBillingMode {
  String label(AppLocalizations loc) => switch (this) {
        InstallmentBillingMode.monthlyLumpNextMonth =>
          loc.installmentModeMonthlyLabel,
        InstallmentBillingMode.dailyEven => loc.installmentModeDailyLabel,
      };

  String description(AppLocalizations loc) => switch (this) {
        InstallmentBillingMode.monthlyLumpNextMonth =>
          loc.installmentModeMonthlyDescription,
        InstallmentBillingMode.dailyEven =>
          loc.installmentModeDailyDescription,
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
