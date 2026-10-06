import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/thousands_formatter.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/currency_provider.dart';
import '../../../providers/budget_settings_provider.dart';
import '../../../providers/savings_planner_provider.dart';

class _IncomeRow {
  _IncomeRow({required String name, required double amount})
      : nameController = TextEditingController(text: name),
        amountController = TextEditingController(
          text: amount == 0 ? '' : NumberFormat('#,###').format(amount),
        );

  final TextEditingController nameController;
  final TextEditingController amountController;

  FixedIncomeItem toItem() => FixedIncomeItem(
        name: nameController.text.trim(),
        amount: double.tryParse(amountController.text.replaceAll(',', '')) ?? 0,
      );

  void dispose() {
    nameController.dispose();
    amountController.dispose();
  }
}

/// 장기 저축 플랜의 '고정수입' 항목을 위저드 밖에서 언제든 추가/수정/삭제하는
/// 바텀시트. 저장하면 합계가 곧바로 [SavingsPlan.monthlyIncome]에 동기화되고,
/// 일/주/월 목표 금액도 새 가용 생활비 기준으로 즉시 재계산·적용된다.
class FixedIncomeManageSheet extends ConsumerStatefulWidget {
  const FixedIncomeManageSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FixedIncomeManageSheet(),
    );
  }

  @override
  ConsumerState<FixedIncomeManageSheet> createState() =>
      _FixedIncomeManageSheetState();
}

class _FixedIncomeManageSheetState
    extends ConsumerState<FixedIncomeManageSheet> {
  late List<_IncomeRow> _rows;

  @override
  void initState() {
    super.initState();
    final plan = ref.read(savingsPlanProvider);
    final incomes = plan.fixedIncomes.isEmpty
        ? [FixedIncomeItem(name: '', amount: plan.monthlyIncome ?? 0)]
        : plan.fixedIncomes;
    _rows = incomes
        .map((e) => _IncomeRow(name: e.name, amount: e.amount))
        .toList();
  }

  @override
  void dispose() {
    for (final row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

  double get _total => _rows.fold<double>(
      0.0, (sum, r) => sum + (double.tryParse(
              r.amountController.text.replaceAll(',', '')) ?? 0));

  void _addRow() => setState(() => _rows.add(_IncomeRow(name: '', amount: 0)));

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
    final newPlan = plan.withFixedIncomes(items);
    await ref.read(savingsPlanProvider.notifier).update(newPlan);
    final monthly =
        (newPlan.monthlyAvailable ?? 0).clamp(0, double.infinity).toDouble();
    final daily = monthly / 30;
    final weekly = daily * 7;
    await ref
        .read(periodTargetAmountsProvider.notifier)
        .setAll(daily: daily, weekly: weekly, monthly: monthly);
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(loc.autoBudgetSetMessage)));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final currency = ref.watch(currencyProvider).currency;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(loc.manageFixedIncomesButton,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                for (var i = 0; i < _rows.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
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
                            inputFormatters: [
                              ThousandsSeparatorInputFormatter()
                            ],
                            decoration: InputDecoration(
                                hintText: '0', suffixText: currency.symbol),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => _removeRow(i),
                        ),
                      ],
                    ),
                  ),
                TextButton.icon(
                    onPressed: _addRow,
                    icon: const Icon(Icons.add),
                    label: Text(loc.addItemButton)),
                const SizedBox(height: 8),
                Text(
                  loc.savingsPlanFixedIncomeTotalLine(currency.format(_total)),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 48,
                  child: FilledButton(
                      onPressed: _save, child: Text(loc.commonSave)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
