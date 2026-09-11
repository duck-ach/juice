import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/week_utils.dart';
import '../../core/widgets/edit_delete_slidable.dart';
import '../../data/models/week_start_day.dart';
import '../../providers/budget_settings_provider.dart';
import '../../providers/calendar_provider.dart';
import '../../providers/category_provider.dart';
import '../../providers/expense_provider.dart';
import '../dashboard/widgets/add_expense_sheet.dart';
import '../dashboard/widgets/expense_actions.dart';
import '../dashboard/widgets/expense_tile.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusedMonth = ref.watch(calendarFocusedMonthProvider);
    final selectedDay = ref.watch(calendarSelectedDayProvider);
    final filter = ref.watch(calendarExpenseFilterProvider);
    final monthTotal = ref.watch(calendarMonthTotalProvider);
    final monthIncomeTotal = ref.watch(calendarMonthIncomeTotalProvider);
    final dailyTotals = ref.watch(calendarDailyTotalsProvider);
    final dailyIncomeMarkers = ref.watch(calendarDailyIncomeMarkersProvider);
    final installmentOnlyDays =
        ref.watch(calendarDailyInstallmentOnlyDaysProvider);
    final dayItems = ref.watch(calendarSelectedDayItemsProvider);
    final weekStartDay = ref.watch(weekStartDayProvider);
    final categories = ref.watch(categoryProvider);
    final categoryMap = {for (final c in categories) c.id: c};
    final formatter = NumberFormat('#,###');

    void goToMonth(DateTime month) {
      final normalized = DateTime(month.year, month.month, 1);
      ref.read(calendarFocusedMonthProvider.notifier).state = normalized;
      ref.read(calendarSelectedDayProvider.notifier).state = normalized;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('캘린더')),
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
              Text('${focusedMonth.year}년 ${focusedMonth.month}월',
                  style: Theme.of(context).textTheme.titleLarge),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => goToMonth(
                    DateTime(focusedMonth.year, focusedMonth.month + 1, 1)),
              ),
            ],
          ),
          Text(
            '이번 달 총 지출 ${formatter.format(monthTotal)}원 · 총 수입 ${formatter.format(monthIncomeTotal)}원',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SegmentedButton<ExpenseFilter>(
              segments: const [
                ButtonSegment(
                    value: ExpenseFilter.variableOnly, label: Text('변동지출만')),
                ButtonSegment(value: ExpenseFilter.all, label: Text('전체 내역')),
              ],
              selected: {filter},
              onSelectionChanged: (selection) => ref
                  .read(calendarExpenseFilterProvider.notifier)
                  .state = selection.first,
            ),
          ),
          const SizedBox(height: 8),
          TableCalendar<void>(
            locale: 'ko_KR',
            firstDay: DateTime(2020, 1, 1),
            lastDay: DateTime(2030, 12, 31),
            focusedDay: focusedMonth,
            startingDayOfWeek: weekStartDay == WeekStartDay.sunday
                ? StartingDayOfWeek.sunday
                : StartingDayOfWeek.monday,
            headerVisible: false,
            rowHeight: _DayCell.cellHeight + _DayCell.cellMargin * 2,
            availableGestures: AvailableGestures.horizontalSwipe,
            daysOfWeekHeight: 24,
            selectedDayPredicate: (day) => isSameDay(day, selectedDay),
            onDaySelected: (selected, focused) {
              // 이전/다음 달의 날짜(outside day)를 탭하면 해당 달로 자연스럽게 이동.
              ref.read(calendarSelectedDayProvider.notifier).state =
                  dateOnly(selected);
              ref.read(calendarFocusedMonthProvider.notifier).state =
                  DateTime(focused.year, focused.month, 1);
            },
            onPageChanged: (focused) => goToMonth(focused),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) => _DayCell(
                day: day,
                total: dailyTotals[dateOnly(day)],
                hasIncome: dailyIncomeMarkers.contains(dateOnly(day)),
                isInstallmentOnly: installmentOnlyDays.contains(dateOnly(day)),
              ),
              outsideBuilder: (context, day, _) => _DayCell(
                day: day,
                total: dailyTotals[dateOnly(day)],
                hasIncome: dailyIncomeMarkers.contains(dateOnly(day)),
                isInstallmentOnly: installmentOnlyDays.contains(dateOnly(day)),
                isOutside: true,
              ),
              todayBuilder: (context, day, _) => _DayCell(
                day: day,
                total: dailyTotals[dateOnly(day)],
                hasIncome: dailyIncomeMarkers.contains(dateOnly(day)),
                isInstallmentOnly: installmentOnlyDays.contains(dateOnly(day)),
                isToday: true,
                isSelected: isSameDay(day, selectedDay),
              ),
              selectedBuilder: (context, day, _) => _DayCell(
                day: day,
                total: dailyTotals[dateOnly(day)],
                hasIncome: dailyIncomeMarkers.contains(dateOnly(day)),
                isInstallmentOnly: installmentOnlyDays.contains(dateOnly(day)),
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
                DateFormat('M월 d일 (E)', 'ko').format(selectedDay),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Expanded(
            child: dayItems.isEmpty
                ? Center(
                    child: Text('지출 없는 상쾌한 날이에요! 🍊',
                        style: Theme.of(context).textTheme.bodyMedium),
                  )
                : ListView.separated(
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
    required this.total,
    this.hasIncome = false,
    this.isInstallmentOnly = false,
    this.isSelected = false,
    this.isToday = false,
    this.isOutside = false,
  });

  final DateTime day;
  final double? total;
  final bool hasIncome;
  final bool isInstallmentOnly;
  final bool isSelected;
  final bool isToday;
  final bool isOutside;

  /// 지출 유무와 무관하게 모든 셀이 동일한 크기를 갖도록 고정하는 값.
  /// TableCalendar의 rowHeight = cellHeight + cellMargin*2로 맞춰준다.
  static const double cellHeight = 46;
  static const double cellMargin = 3;
  static const double _amountRowHeight = 12;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;
    final baseColor = isOutside
        ? theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.35)
        : theme.textTheme.bodyLarge?.color;
    final numberColor = isSelected ? Colors.white : baseColor;
    final amountColor = isSelected
        ? Colors.white.withValues(alpha: 0.9)
        : accent.withValues(alpha: isInstallmentOnly ? 0.45 : 1);
    final hasSpend = total != null && total! > 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: cellHeight,
          margin: const EdgeInsets.all(cellMargin),
          decoration: BoxDecoration(
            color: isSelected
                ? accent
                : (isToday ? accent.withValues(alpha: 0.14) : null),
            borderRadius: BorderRadius.circular(12),
            border: isToday && !isSelected
                ? Border.all(color: accent, width: 1)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '${day.day}',
                style: TextStyle(
                    color: numberColor,
                    fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 13),
              ),
              const SizedBox(height: 2),
              // 금액 유무와 무관하게 항상 같은 높이를 차지하는 플레이스홀더 영역.
              SizedBox(
                height: _amountRowHeight,
                child: Center(
                  child: hasSpend
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              NumberFormat('#,###').format(total),
                              style: TextStyle(
                                  color: amountColor,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      : Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (isSelected
                                    ? Colors.white
                                    : AppColors.citrusYellow)
                                .withValues(alpha: isOutside ? 0.15 : 0.5),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        if (hasIncome)
          Positioned(
            top: cellMargin,
            right: cellMargin,
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.safeGreen),
            ),
          ),
      ],
    );
  }
}
