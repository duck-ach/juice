import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/thousands_formatter.dart';
import '../../../providers/budget_settings_provider.dart';
import '../../../providers/savings_planner_provider.dart';

/// 저축 목표 플래너 4단계 위저드. 완료 시 true를 반환하며 플랜을 저장하고
/// 계산된 일/주/월 목표 금액을 곧바로 적용한다. 도중에 뒤로 나가면 null.
Future<bool?> showSavingsPlanWizard(BuildContext context) {
  return Navigator.of(context).push<bool>(
    MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const SavingsPlanWizardScreen()),
  );
}

class SavingsPlanWizardScreen extends ConsumerStatefulWidget {
  const SavingsPlanWizardScreen({super.key});

  @override
  ConsumerState<SavingsPlanWizardScreen> createState() =>
      _SavingsPlanWizardScreenState();
}

class _WizardFixedExpenseRow {
  _WizardFixedExpenseRow({required String name, required double amount})
      : nameController = TextEditingController(text: name),
        amountController = TextEditingController(
          text: amount == 0 ? '' : NumberFormat('#,###').format(amount),
        );

  final TextEditingController nameController;
  final TextEditingController amountController;

  FixedExpenseItem toItem() => FixedExpenseItem(
        name: nameController.text.trim(),
        amount: double.tryParse(amountController.text.replaceAll(',', '')) ?? 0,
      );

  void dispose() {
    nameController.dispose();
    amountController.dispose();
  }
}

class _SavingsPlanWizardScreenState
    extends ConsumerState<SavingsPlanWizardScreen> {
  static const _presets = [6, 12, 24, 36];

  int _step = 0;
  late final TextEditingController _incomeController;
  late final TextEditingController _goalAmountController;
  late final TextEditingController _yearsController;
  late final TextEditingController _monthsController;
  late List<_WizardFixedExpenseRow> _fixedExpenseRows;
  int? _selectedPreset;
  bool _customDuration = false;

  @override
  void initState() {
    super.initState();
    final plan = ref.read(savingsPlanProvider);
    _incomeController = TextEditingController(
      text: plan.monthlyIncome == null
          ? ''
          : NumberFormat('#,###').format(plan.monthlyIncome),
    );
    _goalAmountController = TextEditingController(
      text: plan.goalAmount == null
          ? ''
          : NumberFormat('#,###').format(plan.goalAmount),
    );
    _yearsController = TextEditingController(
        text: plan.goalYears == 0 ? '' : '${plan.goalYears}');
    _monthsController = TextEditingController(
        text: plan.goalMonths == 0 ? '' : '${plan.goalMonths}');
    if (plan.totalMonths > 0 && _presets.contains(plan.totalMonths)) {
      _selectedPreset = plan.totalMonths;
    } else if (plan.totalMonths > 0) {
      _customDuration = true;
    }
    final expenses = plan.fixedExpenses.isEmpty
        ? SavingsPlan.defaultFixedExpenses
        : plan.fixedExpenses;
    _fixedExpenseRows = expenses
        .map((e) => _WizardFixedExpenseRow(name: e.name, amount: e.amount))
        .toList();
  }

  @override
  void dispose() {
    _incomeController.dispose();
    _goalAmountController.dispose();
    _yearsController.dispose();
    _monthsController.dispose();
    for (final row in _fixedExpenseRows) {
      row.dispose();
    }
    super.dispose();
  }

  double? get _income =>
      double.tryParse(_incomeController.text.replaceAll(',', ''));

  double? get _goalAmount =>
      double.tryParse(_goalAmountController.text.replaceAll(',', ''));

  int get _totalMonths {
    if (!_customDuration && _selectedPreset != null) return _selectedPreset!;
    final y = int.tryParse(_yearsController.text) ?? 0;
    final m = int.tryParse(_monthsController.text) ?? 0;
    return y * 12 + m;
  }

  SavingsPlan _buildPlan({required bool enabled}) {
    return SavingsPlan(
      enabled: enabled,
      monthlyIncome: _income,
      goalYears: _totalMonths ~/ 12,
      goalMonths: _totalMonths % 12,
      goalAmount: _goalAmount,
      fixedExpenses: _fixedExpenseRows.map((r) => r.toItem()).toList(),
    );
  }

  bool get _canProceed => switch (_step) {
        0 => (_income ?? 0) > 0,
        1 => _totalMonths > 0 && (_goalAmount ?? 0) > 0,
        _ => true,
      };

  void _next() => setState(() => _step += 1);

  void _back() {
    if (_step > 0) {
      setState(() => _step -= 1);
    } else {
      Navigator.of(context).pop(false);
    }
  }

  void _selectPreset(int months) {
    setState(() {
      _selectedPreset = months;
      _customDuration = false;
    });
  }

  void _addFixedExpenseRow() {
    setState(() =>
        _fixedExpenseRows.add(_WizardFixedExpenseRow(name: '', amount: 0)));
  }

  void _removeFixedExpenseRow(int index) {
    final removed = _fixedExpenseRows.removeAt(index);
    setState(() {});
    removed.dispose();
  }

  Future<void> _finish() async {
    final plan = _buildPlan(enabled: true);
    final monthly =
        (plan.monthlyAvailable ?? 0).clamp(0, double.infinity).toDouble();
    final daily = monthly / 30;
    final weekly = daily * 7;
    await ref.read(savingsPlanProvider.notifier).update(plan);
    await ref
        .read(periodTargetAmountsProvider.notifier)
        .setAll(daily: daily, weekly: weekly, monthly: monthly);
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _back();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading:
              IconButton(icon: const Icon(Icons.arrow_back), onPressed: _back),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                            value: (_step + 1) / 4, minHeight: 6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('${_step + 1} / 4',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                  child: _buildStep(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed:
                        !_canProceed ? null : (_step == 3 ? _finish : _next),
                    child: Text(_step == 3 ? '이 레시피로 주스 시작하기' : '다음'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep() {
    return switch (_step) {
      0 => _IncomeStep(
          controller: _incomeController, onChanged: () => setState(() {})),
      1 => _GoalStep(
          goalAmountController: _goalAmountController,
          yearsController: _yearsController,
          monthsController: _monthsController,
          presets: _presets,
          selectedPreset: _customDuration ? null : _selectedPreset,
          customDuration: _customDuration,
          onSelectPreset: _selectPreset,
          onSelectCustom: () => setState(() => _customDuration = true),
          onChanged: () => setState(() {}),
        ),
      2 => _FixedExpenseStep(
          rows: _fixedExpenseRows,
          onAdd: _addFixedExpenseRow,
          onRemove: _removeFixedExpenseRow,
          onChanged: () => setState(() {}),
        ),
      _ => _ResultStep(plan: _buildPlan(enabled: true)),
    };
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader(
      {required this.emoji, required this.question, this.subtitle});

  final String emoji;
  final String question;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 40)),
        const SizedBox(height: 16),
        Text(
          question,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}

class _IncomeStep extends StatelessWidget {
  const _IncomeStep({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _StepHeader(
          emoji: '💰',
          question: '매달 들어오는 주스(월 수입)는\n얼마인가요?',
          subtitle: '세후 실제 통장에 찍히는 금액을 적어주세요.',
        ),
        TextField(
          controller: controller,
          autofocus: true,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [ThousandsSeparatorInputFormatter()],
          style: Theme.of(context).textTheme.headlineMedium,
          decoration: const InputDecoration(
              hintText: '0', suffixText: ' 원', border: InputBorder.none),
          onChanged: (_) => onChanged(),
        ),
      ],
    );
  }
}

class _GoalStep extends StatelessWidget {
  const _GoalStep({
    required this.goalAmountController,
    required this.yearsController,
    required this.monthsController,
    required this.presets,
    required this.selectedPreset,
    required this.customDuration,
    required this.onSelectPreset,
    required this.onSelectCustom,
    required this.onChanged,
  });

  final TextEditingController goalAmountController;
  final TextEditingController yearsController;
  final TextEditingController monthsController;
  final List<int> presets;
  final int? selectedPreset;
  final bool customDuration;
  final ValueChanged<int> onSelectPreset;
  final VoidCallback onSelectCustom;
  final VoidCallback onChanged;

  String _presetLabel(int months) =>
      months < 12 ? '$months개월' : '${months ~/ 12}년';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _StepHeader(emoji: '🎯', question: '얼마 동안, 얼마를\n모으고 싶나요?'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final months in presets)
              ChoiceChip(
                label: Text(_presetLabel(months)),
                selected: !customDuration && selectedPreset == months,
                onSelected: (_) => onSelectPreset(months),
              ),
            ChoiceChip(
              label: const Text('직접 입력'),
              selected: customDuration,
              onSelected: (_) => onSelectCustom(),
            ),
          ],
        ),
        if (customDuration) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: yearsController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(labelText: '년'),
                  onChanged: (_) => onChanged(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: monthsController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(labelText: '개월'),
                  onChanged: (_) => onChanged(),
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 28),
        TextField(
          controller: goalAmountController,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [ThousandsSeparatorInputFormatter()],
          style: Theme.of(context).textTheme.headlineSmall,
          decoration:
              const InputDecoration(labelText: '목표 모을 금액', suffixText: '원'),
          onChanged: (_) => onChanged(),
        ),
      ],
    );
  }
}

class _FixedExpenseStep extends StatelessWidget {
  const _FixedExpenseStep({
    required this.rows,
    required this.onAdd,
    required this.onRemove,
    required this.onChanged,
  });

  final List<_WizardFixedExpenseRow> rows;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _StepHeader(
          emoji: '🏠',
          question: '매달 고정으로\n빠져나가는 돈이 있나요?',
          subtitle: '월세, 보험료, 통신비 등 주스 통에 담지 않을 비용이에요.',
        ),
        for (var i = 0; i < rows.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: rows[i].nameController,
                    decoration: const InputDecoration(hintText: '항목명'),
                    onChanged: (_) => onChanged(),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: rows[i].amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [ThousandsSeparatorInputFormatter()],
                    decoration:
                        const InputDecoration(hintText: '0', suffixText: '원'),
                    onChanged: (_) => onChanged(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => onRemove(i),
                ),
              ],
            ),
          ),
        TextButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: const Text('항목 추가')),
      ],
    );
  }
}

class _ResultStep extends StatelessWidget {
  const _ResultStep({required this.plan});

  final SavingsPlan plan;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###');
    final monthly = plan.monthlyAvailable;
    final theme = Theme.of(context);
    final isNegative = monthly != null && monthly < 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _StepHeader(emoji: '🍹', question: '나만의 주스 플랜이\n완성되었어요!'),
        if (monthly == null || isNegative)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '고정지출과 저축액이 수입보다 많아요 😥 이전 단계로 돌아가 목표나 기간을 조정해보세요.',
              style: theme.textTheme.bodyMedium,
            ),
          )
        else
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '월 수입 ${formatter.format(plan.monthlyIncome)}원 - 고정비 ${formatter.format(plan.fixedExpenseTotal)}원 - 월 저축액을 빼면,',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Text.rich(
                  TextSpan(
                    style: theme.textTheme.titleLarge,
                    children: [
                      const TextSpan(text: '이번 주 '),
                      TextSpan(
                        text: '${formatter.format(plan.weeklyAvailable)} mL',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const TextSpan(text: '의 주스를 마실 수 있어요! 🍊'),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '하루 ${formatter.format(plan.dailyAvailable)} mL · 한 달 ${formatter.format(monthly)} mL',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
