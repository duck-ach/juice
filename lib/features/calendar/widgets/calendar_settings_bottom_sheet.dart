import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/compact_currency_formatter.dart';
import '../../../core/widgets/juice_segmented_tab.dart';
import '../../../data/models/week_start_day.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/calendar_display_provider.dart';

/// 캘린더 화면 우측 상단 톱니바퀴로 여는 캘린더 전용 설정 바텀시트. 여기서 바뀌는 값은
/// 모두 캘린더 화면 표시에만 영향을 주고, 홈 대시보드/예산 정산 로직과는 무관하다.
class CalendarSettingsBottomSheet extends ConsumerWidget {
  const CalendarSettingsBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CalendarSettingsBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final startDay = ref.watch(calendarStartDayProvider);
    final amountMode = ref.watch(calendarAmountDisplayModeProvider);
    final showNoSpendStamp = ref.watch(calendarShowNoSpendStampProvider);
    final highlightWeekend = ref.watch(calendarHighlightWeekendProvider);

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(loc.calendarSettingsTitle,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            Text(loc.calendarStartDayLabel,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            JuiceSegmentedTab(
              items: [loc.calendarStartMon, loc.calendarStartSun],
              selectedIndex: startDay == WeekStartDay.sunday ? 1 : 0,
              onTabChanged: (index) => ref
                  .read(calendarStartDayProvider.notifier)
                  .setDay(index == 1 ? WeekStartDay.sunday : WeekStartDay.monday),
            ),
            const SizedBox(height: 20),
            Text(loc.calendarAmountMode,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            JuiceSegmentedTab(
              items: [loc.calendarCompactAmount, loc.calendarFullAmount],
              selectedIndex:
                  amountMode == CalendarAmountDisplayMode.full ? 1 : 0,
              onTabChanged: (index) => ref
                  .read(calendarAmountDisplayModeProvider.notifier)
                  .setMode(index == 1
                      ? CalendarAmountDisplayMode.full
                      : CalendarAmountDisplayMode.compact),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: showNoSpendStamp,
              onChanged: (value) => ref
                  .read(calendarShowNoSpendStampProvider.notifier)
                  .setEnabled(value),
              title: Text(loc.calendarShowNoSpendStamp),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: highlightWeekend,
              onChanged: (value) => ref
                  .read(calendarHighlightWeekendProvider.notifier)
                  .setEnabled(value),
              title: Text(loc.calendarHighlightWeekend),
            ),
          ],
        ),
      ),
    );
  }
}
