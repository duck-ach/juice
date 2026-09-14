import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/juice_saving_provider.dart';
import '../../../providers/juice_theme_provider.dart';
import 'saving_history_bottom_sheet.dart';

/// 홈 화면 주스 팁 카드 위에 얹는 컴팩트한 누적 절약 뱃지. 탭하면 주기별 정산 내역을
/// 보여주는 [SavingHistoryBottomSheet]가 열린다.
class SavedJuiceBadge extends ConsumerWidget {
  const SavedJuiceBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final total = ref.watch(totalSavedJuiceProvider);
    final themeColor = ref.watch(resolvedJuiceThemeProvider).highColor;
    final formatter = NumberFormat('#,###');

    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => SavingHistoryBottomSheet.show(context),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: themeColor.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🧃', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              Text(
                loc.savedJuiceBadgeLabel(formatter.format(total)),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: themeColor,
                ),
              ),
              Icon(Icons.chevron_right, size: 15, color: themeColor),
            ],
          ),
        ),
      ),
    );
  }
}
