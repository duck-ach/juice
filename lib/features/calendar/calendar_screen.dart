import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/compact_currency_formatter.dart';
import '../../core/utils/week_utils.dart';
import '../../core/widgets/edit_delete_slidable.dart';
import '../../core/widgets/juice_segmented_tab.dart';
import '../../data/models/week_start_day.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/calendar_display_provider.dart';
import '../../providers/calendar_provider.dart';
import '../../providers/category_provider.dart';
import '../../providers/currency_provider.dart';
import '../../providers/expense_provider.dart';
import '../../providers/juice_theme_provider.dart';
import '../dashboard/widgets/add_expense_sheet.dart';
import '../dashboard/widgets/expense_actions.dart';
import '../dashboard/widgets/expense_tile.dart';
import 'widgets/calendar_settings_bottom_sheet.dart';

/// [month]를 [startDay] 기준 달력 격자로 그릴 때 필요한 주(row) 수(보통 5, 1일의
/// 요일에 따라 6이 될 수 있음). TableCalendar가 내부적으로 계산하는 것과 같은 규칙을
/// 미리 계산해, 6주짜리 달에서만 셀 높이를 살짝 줄여 세로 오버플로우를 막는 데 쓴다.
int _monthGridRowCount(DateTime month, WeekStartDay startDay) {
  final first = DateTime(month.year, month.month, 1);
  final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
  final offset = startDay == WeekStartDay.sunday
      ? first.weekday % 7
      : first.weekday - 1;
  return ((offset + daysInMonth) / 7).ceil();
}

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final focusedMonth = ref.watch(calendarFocusedMonthProvider);
    final selectedDay = ref.watch(calendarSelectedDayProvider);
    final filter = ref.watch(calendarExpenseFilterProvider);
    final monthTotal = ref.watch(calendarMonthTotalProvider);
    final monthIncomeTotal = ref.watch(calendarMonthIncomeTotalProvider);
    final monthSavingsTotal = ref.watch(calendarMonthSavingsTotalProvider);
    final dailyTotals = ref.watch(calendarDailyTotalsProvider);
    final dailyIncomeTotals = ref.watch(calendarDailyIncomeTotalsProvider);
    final dailySavingsTotals = ref.watch(calendarDailySavingsTotalsProvider);
    final installmentOnlyDays =
        ref.watch(calendarDailyInstallmentOnlyDaysProvider);
    final noSpendDays = ref.watch(calendarNoSpendDaysProvider);
    final corporateDays = ref.watch(calendarDailyCorporateDaysProvider);
    final fruitEmoji = ref.watch(resolvedJuiceThemeProvider).emoji;
    final dayItems = ref.watch(calendarSelectedDayItemsProvider);
    final calendarStartDay = ref.watch(calendarStartDayProvider);
    final categories = ref.watch(categoryProvider);
    final categoryMap = {for (final c in categories) c.id: c};
    final currency = ref.watch(currencyProvider).currency;
    final amountDisplayMode = ref.watch(calendarAmountDisplayModeProvider);
    final calendarFormat = ref.watch(calendarFormatProvider);
    final showNoSpendStamp = ref.watch(calendarShowNoSpendStampProvider);
    final highlightWeekend = ref.watch(calendarHighlightWeekendProvider);
    final effectiveNoSpendDays =
        showNoSpendStamp ? noSpendDays : const <DateTime>{};
    // 1일의 요일에 따라 6주 라인까지 그려지는 달(예: 8월 등)에서만 셀을 살짝 압축해,
    // 글자 크기는 그대로 두고도 세로 오버플로우 없이 화면에 다 들어가게 한다.
    final isSixWeekMonth =
        _monthGridRowCount(focusedMonth, calendarStartDay) >= 6;

    void goToMonth(DateTime month) {
      final normalized = DateTime(month.year, month.month, 1);
      ref.read(calendarFocusedMonthProvider.notifier).state = normalized;
      ref.read(calendarSelectedDayProvider.notifier).state = normalized;
    }

    void setCalendarFormat(CalendarFormat format) {
      if (ref.read(calendarFormatProvider) != format) {
        ref.read(calendarFormatProvider.notifier).state = format;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.calendarTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: loc.calendarSettingsTitle,
            onPressed: () => CalendarSettingsBottomSheet.show(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => goToMonth(
                    DateTime(focusedMonth.year, focusedMonth.month - 1, 1)),
              ),
              Text(DateFormat.yMMMM(loc.localeName).format(focusedMonth),
                  style: Theme.of(context).textTheme.titleLarge),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => goToMonth(
                    DateTime(focusedMonth.year, focusedMonth.month + 1, 1)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 4,
              children: [
                Text('${loc.expenseLabel} ${currency.format(monthTotal)}',
                    style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  '${loc.incomeLabel} ${currency.format(monthIncomeTotal)}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.safeGreen),
                ),
                Text(
                  '${loc.savingsLabel} ${currency.format(monthSavingsTotal)}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.softPink),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: JuiceSegmentedTab(
              items: [loc.filterVariableOnlyShort, loc.filterAllShort],
              selectedIndex: ExpenseFilter.values.indexOf(filter),
              onTabChanged: (index) => ref
                  .read(calendarExpenseFilterProvider.notifier)
                  .state = ExpenseFilter.values[index],
            ),
          ),
          const SizedBox(height: 6),
          TableCalendar<void>(
            locale: loc.localeName,
            firstDay: DateTime(2020, 1, 1),
            lastDay: DateTime(2030, 12, 31),
            focusedDay: selectedDay,
            calendarFormat: calendarFormat,
            availableCalendarFormats: {
              CalendarFormat.month: '',
              CalendarFormat.week: '',
            },
            startingDayOfWeek: calendarStartDay == WeekStartDay.sunday
                ? StartingDayOfWeek.sunday
                : StartingDayOfWeek.monday,
            headerVisible: false,
            rowHeight: _DayCell.rowHeightFor(isSixWeekMonth),
            // 가로 스와이프(월/주 이동)에 더해, 세로 스와이프로도 월간⇄주간 뷰를 직접
            // 접었다 펼 수 있게 한다(아래 상세 내역 영역의 드래그와 동일한 동작).
            availableGestures: AvailableGestures.all,
            daysOfWeekHeight: 20,
            selectedDayPredicate: (day) => isSameDay(day, selectedDay),
            onDaySelected: (selected, focused) {
              // 이전/다음 달의 날짜(outside day)를 탭하면 해당 달로 자연스럽게 이동.
              ref.read(calendarSelectedDayProvider.notifier).state =
                  dateOnly(selected);
              ref.read(calendarFocusedMonthProvider.notifier).state =
                  DateTime(focused.year, focused.month, 1);
            },
            onFormatChanged: setCalendarFormat,
            onPageChanged: (focused) {
              if (calendarFormat == CalendarFormat.week) {
                // 주간 뷰에서는 한 주씩만 이동 — 월 1일로 되돌리지 않는다.
                ref.read(calendarSelectedDayProvider.notifier).state =
                    dateOnly(focused);
                ref.read(calendarFocusedMonthProvider.notifier).state =
                    DateTime(focused.year, focused.month, 1);
              } else {
                goToMonth(focused);
              }
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) => _DayCell(
                day: day,
                expenseTotal: dailyTotals[dateOnly(day)],
                incomeTotal: dailyIncomeTotals[dateOnly(day)],
                savingsTotal: dailySavingsTotals[dateOnly(day)],
                currencyCode: currency.code,
                displayMode: amountDisplayMode,
                isInstallmentOnly: installmentOnlyDays.contains(dateOnly(day)),
                isNoSpendDay: effectiveNoSpendDays.contains(dateOnly(day)),
                isCorporateDay: corporateDays.contains(dateOnly(day)),
                fruitEmoji: fruitEmoji,
                highlightWeekend: highlightWeekend,
                compact: isSixWeekMonth,
              ),
              outsideBuilder: (context, day, _) => _DayCell(
                day: day,
                expenseTotal: dailyTotals[dateOnly(day)],
                incomeTotal: dailyIncomeTotals[dateOnly(day)],
                savingsTotal: dailySavingsTotals[dateOnly(day)],
                currencyCode: currency.code,
                displayMode: amountDisplayMode,
                isInstallmentOnly: installmentOnlyDays.contains(dateOnly(day)),
                isNoSpendDay: effectiveNoSpendDays.contains(dateOnly(day)),
                isCorporateDay: corporateDays.contains(dateOnly(day)),
                fruitEmoji: fruitEmoji,
                highlightWeekend: highlightWeekend,
                compact: isSixWeekMonth,
                isOutside: true,
              ),
              todayBuilder: (context, day, _) => _DayCell(
                day: day,
                expenseTotal: dailyTotals[dateOnly(day)],
                incomeTotal: dailyIncomeTotals[dateOnly(day)],
                savingsTotal: dailySavingsTotals[dateOnly(day)],
                currencyCode: currency.code,
                displayMode: amountDisplayMode,
                isInstallmentOnly: installmentOnlyDays.contains(dateOnly(day)),
                isNoSpendDay: effectiveNoSpendDays.contains(dateOnly(day)),
                isCorporateDay: corporateDays.contains(dateOnly(day)),
                fruitEmoji: fruitEmoji,
                highlightWeekend: highlightWeekend,
                compact: isSixWeekMonth,
                isToday: true,
                isSelected: isSameDay(day, selectedDay),
              ),
              selectedBuilder: (context, day, _) => _DayCell(
                day: day,
                expenseTotal: dailyTotals[dateOnly(day)],
                incomeTotal: dailyIncomeTotals[dateOnly(day)],
                savingsTotal: dailySavingsTotals[dateOnly(day)],
                currencyCode: currency.code,
                displayMode: amountDisplayMode,
                isInstallmentOnly: installmentOnlyDays.contains(dateOnly(day)),
                isNoSpendDay: effectiveNoSpendDays.contains(dateOnly(day)),
                isCorporateDay: corporateDays.contains(dateOnly(day)),
                fruitEmoji: fruitEmoji,
                highlightWeekend: highlightWeekend,
                compact: isSixWeekMonth,
                isSelected: true,
                isToday: isSameDay(day, DateTime.now()),
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat('M.d (E)', loc.localeName).format(selectedDay),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Expanded(
            // 상세 내역을 위로 드래그(스크롤)하면 캘린더를 주간 뷰로 접고, 아래로
            // 당기면 다시 월간 뷰로 펼친다 — 캘린더 자체의 세로 스와이프와 동일한 동작.
            child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction == ScrollDirection.reverse) {
                  setCalendarFormat(CalendarFormat.week);
                } else if (notification.direction == ScrollDirection.forward) {
                  setCalendarFormat(CalendarFormat.month);
                }
                return false;
              },
              child: dayItems.isEmpty
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: 200,
                        child: Center(
                          child: Text(loc.noExpenseTodayMessage,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ),
                    )
                  : ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 96),
                      itemCount: dayItems.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final expense = dayItems[index];
                        return EditDeleteSlidable(
                          key: ValueKey(expense.id),
                          onEdit: () => showAddExpenseSheet(context,
                              editingExpense: expense),
                          onDelete: () =>
                              deleteExpenseWithUndo(context, ref, expense),
                          child: ExpenseTile(
                            expense: expense,
                            category: categoryMap[expense.categoryId],
                            onTap: () => showAddExpenseSheet(context,
                                editingExpense: expense),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'calendar_fab',
        onPressed: () => showAddExpenseSheet(context, initialDate: selectedDay),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.expenseTotal,
    required this.incomeTotal,
    this.savingsTotal,
    required this.currencyCode,
    required this.displayMode,
    this.isInstallmentOnly = false,
    this.isNoSpendDay = false,
    this.isCorporateDay = false,
    this.fruitEmoji = '🍊',
    this.highlightWeekend = false,
    this.compact = false,
    this.isSelected = false,
    this.isToday = false,
    this.isOutside = false,
  });

  final DateTime day;
  final double? expenseTotal;
  final double? incomeTotal;
  final double? savingsTotal;

  /// 셀 안의 축약 금액 표기에 쓸 기준 통화 코드(예: 'KRW', 'USD').
  final String currencyCode;

  /// 금액 표시 방식(축약형/확장형).
  final CalendarAmountDisplayMode displayMode;
  final bool isInstallmentOnly;

  /// 순수 변동 지출이 0원인 '무지출 성공' 날인지. true면 날짜 숫자 옆에 [fruitEmoji]를 찍는다.
  /// [isCorporateDay]가 true면 우선순위가 밀려 표시되지 않는다(좁은 셀 폭 보호).
  final bool isNoSpendDay;

  /// 법인/업무용 카드 결제가 있는 날인지. true면 날짜 숫자 옆에 🏢 스탬프를 찍는다.
  final bool isCorporateDay;

  /// 현재 주스 테마의 시그니처 과일 이모지(무지출 성공 스탬프용).
  final String fruitEmoji;

  /// 토요일은 파랑, 일요일은 빨강으로 날짜 숫자 색을 강조할지(선택된 셀은 항상 흰색
  /// 유지 — 강조하지 않음).
  final bool highlightWeekend;

  /// 6주 라인까지 그려지는 달(1일의 요일에 따라 8월 등)에서 true — 글자 크기는 그대로
  /// 두고 셀 안의 여백(패딩)만 줄여 세로 오버플로우를 막는다. [_amountLineHeight]는
  /// 폰트(8.5)보다 항상 크게 유지해 FittedBox가 절대 글자를 축소하지 않는다.
  final bool compact;
  final bool isSelected;
  final bool isToday;
  final bool isOutside;

  /// 지출/수입 유무와 무관하게, 그리고 월간/주간(접힘) 뷰와 무관하게 모든 셀이 항상
  /// 동일한 크기·폰트를 갖도록 고정하는 값들. 주간 뷰는 TableCalendar가 다른 주(row)를
  /// 숨기는 것뿐, 남은 한 줄의 셀 내용 자체는 월간 뷰와 완전히 동일하게 렌더링한다.
  double get cellHeight => compact ? 54 : 62;
  double get cellMargin => compact ? 2 : 3;
  double get _numberGap => compact ? 1 : 2;

  /// 수입/지출/저축 각 줄이 차지하는 고정 슬롯 높이. 몇 줄이 실제로 채워지든 이 값은
  /// 변하지 않아 폰트가 임의로 축소되지 않는다(FittedBox scaleDown 금지) — 8.5pt 폰트의
  /// 실제 렌더 높이(8.5*1.1≈9.35)보다 항상 여유 있게 크다(compact에서도 10.5 ≥ 9.35).
  double get _amountLineHeight => compact ? 10.5 : 13;
  double get _amountAreaHeight => _amountLineHeight * 3;
  static const _amountTextStyleBase = TextStyle(
      fontSize: 8.5,
      height: 1.1,
      letterSpacing: -0.4,
      fontWeight: FontWeight.w700);

  /// [TableCalendar.rowHeight]에 그대로 대입할 셀 높이(마진 포함).
  static double rowHeightFor(bool compact) =>
      (compact ? 54 : 62) + (compact ? 2 : 3) * 2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;
    final baseColor = isOutside
        ? theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.35)
        : theme.textTheme.bodyLarge?.color;
    Color? weekendColor;
    if (highlightWeekend && !isSelected) {
      final weekendAccent = day.weekday == DateTime.saturday
          ? AppColors.saturdayBlue
          : (day.weekday == DateTime.sunday ? AppColors.warningCherry : null);
      weekendColor = weekendAccent?.withValues(alpha: isOutside ? 0.4 : 1);
    }
    final numberColor = isSelected ? Colors.white : (weekendColor ?? baseColor);
    final hasExpense = expenseTotal != null && expenseTotal! > 0;
    final hasIncome = incomeTotal != null && incomeTotal! > 0;
    final hasSavings = savingsTotal != null && savingsTotal! > 0;
    final expenseColor = isSelected
        ? Colors.white
        : AppColors.warningCherry
            .withValues(alpha: isInstallmentOnly ? 0.45 : 1);
    final incomeColor = isSelected ? Colors.white : AppColors.safeGreen;
    final savingsColor = isSelected ? Colors.white : AppColors.softPink;

    // 컴팩트 축약(+335만 등)이 기본이라 평소엔 꽉 차지 않지만, 확장형(콤마 풀 표기)처럼
    // 슬롯 폭을 넘는 긴 숫자가 들어와도 말줄임 대신 그 줄만 살짝 축소해 한 줄에 담는다.
    Widget amountSlot(bool has, String text, Color color) => SizedBox(
          height: _amountLineHeight,
          child: has
              ? FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(text,
                      maxLines: 1,
                      style: _amountTextStyleBase.copyWith(color: color)),
                )
              : null,
        );

    return Container(
      height: cellHeight,
      width: double.infinity,
      margin: EdgeInsets.all(cellMargin),
      decoration: BoxDecoration(
        color: isSelected
            ? accent
            : (isToday ? accent.withValues(alpha: 0.14) : null),
        borderRadius: BorderRadius.circular(12),
        border:
            isToday && !isSelected ? Border.all(color: accent, width: 1) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isCorporateDay) ...[
                const Text('🏢', style: TextStyle(fontSize: 10.5)),
                const SizedBox(width: 2),
              ] else if (isNoSpendDay) ...[
                Text(fruitEmoji, style: const TextStyle(fontSize: 10.5)),
                const SizedBox(width: 2),
              ],
              Text(
                '${day.day}',
                style: TextStyle(
                    color: numberColor,
                    fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 10.5),
              ),
            ],
          ),
          SizedBox(height: _numberGap),
          SizedBox(
            height: _amountAreaHeight,
            child: !hasIncome && !hasExpense && !hasSavings
                ? Center(
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            (isSelected ? Colors.white : AppColors.citrusYellow)
                                .withValues(alpha: isOutside ? 0.15 : 0.5),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        amountSlot(
                            hasIncome,
                            '+${hasIncome ? formatCalendarAmount(incomeTotal!, currencyCode, displayMode) : ''}',
                            incomeColor),
                        amountSlot(
                            hasExpense,
                            '-${hasExpense ? formatCalendarAmount(expenseTotal!, currencyCode, displayMode) : ''}',
                            expenseColor),
                        amountSlot(
                            hasSavings,
                            hasSavings
                                ? formatCalendarAmount(
                                    savingsTotal!, currencyCode, displayMode)
                                : '',
                            savingsColor),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
