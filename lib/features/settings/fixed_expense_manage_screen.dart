import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/utils/thousands_formatter.dart';
import '../../core/widgets/juice_appbar_title.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/budget_settings_provider.dart';
import '../../providers/fixed_expense_autofill_provider.dart';
import '../../providers/savings_planner_provider.dart';

class _ExpenseRow {
  _ExpenseRow({
    required String name,
    required double amount,
    required this.enabled,
    required this.dayOfMonth,
  })  : nameController = TextEditingController(text: name),
        amountController = TextEditingController(
          text: amount == 0 ? '' : NumberFormat('#,###').format(amount),
        );

  final TextEditingController nameController;
  final TextEditingController amountController;
  bool enabled;
  int dayOfMonth;

  FixedExpenseItem toItem() => FixedExpenseItem(
        name: nameController.text.trim(),
        amount: double.tryParse(amountController.text.replaceAll(',', '')) ?? 0,
        enabled: enabled,
        dayOfMonth: dayOfMonth,
      );

  void dispose() {
    nameController.dispose();
    amountController.dispose();
  }
}

/// 고정지출(월세, 통신비 등) 항목을 관리하는 독립 서브 화면. 장기 저축 플랜을 켜지
/// 않은(주 예산만 쓰는) 유저도 여기서 고정지출을 자유롭게 추가/수정/삭제할 수 있고,
/// 상단 마스터 스위치로 캘린더 자동 기입 전체를 켜고 끄거나, 항목별로 개별 토글할 수
/// 있다.
class FixedExpenseManageScreen extends ConsumerStatefulWidget {
  const FixedExpenseManageScreen({super.key});

  @override
  ConsumerState<FixedExpenseManageScreen> createState() =>
      _FixedExpenseManageScreenState();
}

class _FixedExpenseManageScreenState
    extends ConsumerState<FixedExpenseManageScreen> {
  late List<_ExpenseRow> _rows;

  @override
  void initState() {
    super.initState();
    final plan = ref.read(savingsPlanProvider);
    final expenses = plan.fixedExpenses.isEmpty
        ? [const FixedExpenseItem(name: '', amount: 0)]
        : plan.fixedExpenses;
    _rows = expenses
        .map((e) => _ExpenseRow(
              name: e.name,
              amount: e.amount,
              enabled: e.enabled,
              dayOfMonth: e.dayOfMonth,
            ))
        .toList();
  }

  @override
  void dispose() {
    for (final row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

  void _addRow() => setState(() => _rows
      .add(_ExpenseRow(name: '', amount: 0, enabled: true, dayOfMonth: 1)));

  void _removeRow(int index) {
    final removed = _rows.removeAt(index);
    setState(() {});
    removed.dispose();
  }

  Future<void> _save() async {
    final loc = AppLocalizations.of(context)!;
    final items = _rows
        .map((r) => r.toItem())
        .where((i) => i.name.isNotEmpty || i.amount > 0)
        .toList();
    final plan = ref.read(savingsPlanProvider);
    final newPlan = plan.copyWith(fixedExpenses: items);
    await ref.read(savingsPlanProvider.notifier).update(newPlan);
    final monthly =
        (newPlan.monthlyAvailable ?? 0).clamp(0, double.infinity).toDouble();
    final daily = monthly / 30;
    final weekly = daily * 7;
    await ref
        .read(periodTargetAmountsProvider.notifier)
        .setAll(daily: daily, weekly: weekly, monthly: monthly);
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(loc.autoBudgetSetMessage)));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final autoFillEnabled = ref.watch(fixedExpenseAutoFillEnabledProvider);

    return Scaffold(
      appBar: AppBar(
          title: JuiceAppBarTitle(loc.menuFixedExpenseManagementTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              loc.fixedExpenseManageInfoBanner,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            margin: EdgeInsets.zero,
            child: SwitchListTile(
              secondary: const Text('📅', style: TextStyle(fontSize: 22)),
              value: autoFillEnabled,
              onChanged: (value) => ref
                  .read(fixedExpenseAutoFillEnabledProvider.notifier)
                  .setEnabled(value),
              title: Text(loc.calendarAutoFillTitle),
              subtitle: Text(loc.calendarAutoFillSubtitle),
            ),
          ),
          const SizedBox(height: 20),
          Text(loc.menuFixedExpenseManagementTitle,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          for (var i = 0; i < _rows.length; i++)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Theme.of(context).dividerColor.withValues(alpha: 0.4))),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _rows[i].nameController,
                          decoration:
                              InputDecoration(hintText: loc.itemNameHint),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _rows[i].amountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [ThousandsSeparatorInputFormatter()],
                          decoration: InputDecoration(
                              hintText: '0', suffixText: loc.wonUnit),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      Switch(
                        value: _rows[i].enabled,
                        onChanged: (value) =>
                            setState(() => _rows[i].enabled = value),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => _removeRow(i),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(loc.fixedExpensePaymentDayLabel,
                          style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(width: 8),
                      DropdownButton<int>(
                        value: _rows[i].dayOfMonth,
                        underline: const SizedBox.shrink(),
                        items: [
                          for (var d = 1; d <= 31; d++)
                            DropdownMenuItem(
                                value: d,
                                child: Text(loc.fixedExpenseDayOptionLabel(d))),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _rows[i].dayOfMonth = value);
                        },
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          loc.fixedExpenseAutoFillDayCaption(
                              _rows[i].dayOfMonth),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Theme.of(context).hintColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          TextButton.icon(
              onPressed: _addRow,
              icon: const Icon(Icons.add),
              label: Text(loc.addItemButton)),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: FilledButton(onPressed: _save, child: Text(loc.commonSave)),
          ),
        ],
      ),
    );
  }
}
