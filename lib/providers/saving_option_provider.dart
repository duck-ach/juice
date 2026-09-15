import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';
import '../l10n/app_localizations.dart';

const _savingOptionKey = 'savingOption';

/// 주기가 마감됐을 때 남은 주스(예산)를 어떻게 처리할지.
enum SavingOption { rollover, savings }

extension SavingOptionLabel on SavingOption {
  String label(AppLocalizations loc) => switch (this) {
        SavingOption.rollover => loc.savingOptionRollover,
        SavingOption.savings => loc.savingOptionSavings,
      };
}

/// 남긴 주스 처리 방식(이월/저축) 선택값. 기본값은 저축(savings).
class SavingOptionNotifier extends Notifier<SavingOption> {
  @override
  SavingOption build() {
    final stored = Hive.box(HiveBoxes.settings).get(_savingOptionKey) as String?;
    return SavingOption.values.firstWhere(
      (o) => o.name == stored,
      orElse: () => SavingOption.savings,
    );
  }

  Future<void> setOption(SavingOption option) async {
    await Hive.box(HiveBoxes.settings).put(_savingOptionKey, option.name);
    state = option;
  }
}

final savingOptionProvider =
    NotifierProvider<SavingOptionNotifier, SavingOption>(
        SavingOptionNotifier.new);
