import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/thousands_formatter.dart';
import '../../../core/widgets/juice_choice_chip.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/budget_settings_provider.dart';
import '../../../providers/savings_planner_provider.dart';

/// 저축 목표 플래너 위저드. 소득 형태(고정/불규칙/용돈)에 따라 스텝 구성 자체가
/// 달라진다(아래 [_SavingsPlanWizardScreenState._steps] 참고). 완료 시 true를
/// 반환하며 플랜을 저장하고 계산된 일/주/월 목표 금액을 곧바로 적용한다. 도중에
/// 뒤로 나가면 null.
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

/// 위저드 화면 하나하나의 논리적 단위. 실제로 몇 개, 어떤 순서로 나올지는
/// [_SavingsPlanWizardScreenState._steps]가 소득 형태에 따라 결정한다.
enum _WizardStep { income, weeklyExpense, goal, fixedExpense, result }

class _SavingsPlanWizardScreenState
    extends ConsumerState<SavingsPlanWizardScreen> {
  static const _presets = [6, 12, 24, 36];
  static const _weeklyExpensePresets = [100000, 150000, 200000, 300000];

  int _step = 0;
  late IncomeType _incomeType;
  late AllowanceSubType _allowanceSubType;
  late IncomeFrequency _incomeFrequency;
  late final TextEditingController _incomeController;
  late final TextEditingController _weeklyExpenseController;
  late final TextEditingController _goalAmountController;
  late final TextEditingController _yearsController;
  late final TextEditingController _monthsController;
  late List<_WizardFixedExpenseRow> _fixedExpenseRows;
  int? _selectedPreset;
  bool _customDuration = false;

  /// 소득 형태별 스텝 구성.
  /// - 불규칙 소득: 목표를 직접 정하지 않고 최소 안전 수입에서 역산하므로 목표 스텝 없음.
  /// - 용돈·시드머니(비정기): 고정비도 의미가 없어 생략 — 질문 하나로 바로 결과.
  List<_WizardStep> get _steps {
    if (_incomeType == IncomeType.irregular) {
      return const [
        _WizardStep.income,
        _WizardStep.weeklyExpense,
        _WizardStep.fixedExpense,
        _WizardStep.result,
      ];
    }
    if (_incomeType == IncomeType.allowance &&
        _allowanceSubType == AllowanceSubType.irregular) {
      return const [_WizardStep.income, _WizardStep.result];
    }
    return const [
      _WizardStep.income,
      _WizardStep.goal,
      _WizardStep.fixedExpense,
      _WizardStep.result,
    ];
  }

  bool get _usesFrequency =>
      _incomeType == IncomeType.fixed ||
      (_incomeType == IncomeType.allowance &&
          _allowanceSubType == AllowanceSubType.regular);

  @override
  void initState() {
    super.initState();
    final plan = ref.read(savingsPlanProvider);
    _incomeType = plan.incomeType;
    _allowanceSubType = plan.allowanceSubType ?? AllowanceSubType.regular;
    _incomeFrequency = plan.incomeFrequency;
    _incomeController = TextEditingController(
      text: plan.monthlyIncome == null
          ? ''
          : NumberFormat('#,###')
              .format(_incomeFrequency.rawFromMonthly(plan.monthlyIncome!)),
    );
    _weeklyExpenseController = TextEditingController(
      text: plan.weeklyLivingExpense == null
          ? ''
          : NumberFormat('#,###').format(plan.weeklyLivingExpense),
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
    _weeklyExpenseController.dispose();
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

  double? get _weeklyExpense =>
      double.tryParse(_weeklyExpenseController.text.replaceAll(',', ''));

  double? get _goalAmount =>
      double.tryParse(_goalAmountController.text.replaceAll(',', ''));

  int get _totalMonths {
    if (!_customDuration && _selectedPreset != null) return _selectedPreset!;
    final y = int.tryParse(_yearsController.text) ?? 0;
    final m = int.tryParse(_monthsController.text) ?? 0;
    return y * 12 + m;
  }

  SavingsPlan _buildPlan({required bool enabled}) {
    final rawAmount = _income ?? 0;
    final standardizedIncome =
        _usesFrequency ? _incomeFrequency.monthlyEquivalent(rawAmount) : rawAmount;
    final isAllowanceIrregular = _incomeType == IncomeType.allowance &&
        _allowanceSubType == AllowanceSubType.irregular;

    if (_incomeType == IncomeType.irregular) {
      final draft = SavingsPlan(
        monthlyIncome: standardizedIncome,
        incomeType: _incomeType,
        weeklyLivingExpense: _weeklyExpense ?? 0,
        fixedExpenses: _fixedExpenseRows.map((r) => r.toItem()).toList(),
      );
      return draft.copyWith(
        enabled: enabled,
        goalYears: 1,
        goalMonths: 0,
        goalAmount: draft.variableIncomeAnnualMinSavings ?? 0,
      );
    }

    if (isAllowanceIrregular) {
      return SavingsPlan(
        enabled: enabled,
        monthlyIncome: standardizedIncome,
        incomeType: _incomeType,
        allowanceSubType: _allowanceSubType,
        goalYears: 1,
        goalMonths: 0,
        goalAmount: standardizedIncome * 12,
        fixedExpenses: const [],
      );
    }

    return SavingsPlan(
      enabled: enabled,
      monthlyIncome: standardizedIncome,
      incomeType: _incomeType,
      incomeFrequency: _incomeFrequency,
      allowanceSubType: _incomeType == IncomeType.allowance ? _allowanceSubType : null,
      goalYears: _totalMonths ~/ 12,
      goalMonths: _totalMonths % 12,
      goalAmount: _goalAmount,
      fixedExpenses: _fixedExpenseRows.map((r) => r.toItem()).toList(),
    );
  }

  bool get _canProceed => switch (_steps[_step]) {
        _WizardStep.income => (_income ?? 0) > 0,
        _WizardStep.goal => _totalMonths > 0 && (_goalAmount ?? 0) > 0,
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

  void _selectIncomeType(IncomeType type) {
    setState(() {
      _incomeType = type;
      _step = _step.clamp(0, _steps.length - 1);
    });
  }

  void _selectAllowanceSubType(AllowanceSubType type) {
    setState(() {
      _allowanceSubType = type;
      _step = _step.clamp(0, _steps.length - 1);
    });
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
    // 위저드로 플랜을 통째로 다시 짜는 것이므로 저축 페이스 기준 시각을 새로 찍는다
    // (소득만 갱신하는 재조정과 달리, 이건 사실상 새 플랜 시작으로 취급).
    final plan = _buildPlan(enabled: true).copyWith(createdAt: DateTime.now());
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
    final loc = AppLocalizations.of(context)!;
    final steps = _steps;
    final currentStep = _step.clamp(0, steps.length - 1);
    final isLastStep = currentStep == steps.length - 1;

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
                            value: (currentStep + 1) / steps.length,
                            minHeight: 6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('${currentStep + 1} / ${steps.length}',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                  child: _buildStep(loc, steps[currentStep]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: !_canProceed ? null : (isLastStep ? _finish : _next),
                    child: Text(isLastStep ? loc.startWithLongPlan : loc.commonNext),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(AppLocalizations loc, _WizardStep step) {
    return switch (step) {
      _WizardStep.income => _IncomeStep(
          controller: _incomeController,
          incomeType: _incomeType,
          allowanceSubType: _allowanceSubType,
          incomeFrequency: _incomeFrequency,
          onSelectIncomeType: _selectIncomeType,
          onSelectAllowanceSubType: _selectAllowanceSubType,
          onSelectFrequency: (freq) => setState(() => _incomeFrequency = freq),
          onChanged: () => setState(() {}),
        ),
      _WizardStep.weeklyExpense => _WeeklyExpenseStep(
          controller: _weeklyExpenseController,
          presets: _weeklyExpensePresets,
          onChanged: () => setState(() {}),
        ),
      _WizardStep.goal => _GoalStep(
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
      _WizardStep.fixedExpense => _FixedExpenseStep(
          rows: _fixedExpenseRows,
          onAdd: _addFixedExpenseRow,
          onRemove: _removeFixedExpenseRow,
          onChanged: () => setState(() {}),
        ),
      _WizardStep.result => _ResultStep(plan: _buildPlan(enabled: true)),
    };
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader(
      {super.key, required this.emoji, required this.question, this.subtitle});

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

extension on IncomeType {
  String label(AppLocalizations loc) => switch (this) {
        IncomeType.fixed => loc.incomeTypeFixed,
        IncomeType.irregular => loc.incomeTypeVariable,
        IncomeType.allowance => loc.incomeTypeAllowance,
      };
}

extension on IncomeFrequency {
  String label(AppLocalizations loc) => switch (this) {
        IncomeFrequency.monthly => loc.freqMonthly,
        IncomeFrequency.biweekly => loc.freqBiweekly,
        IncomeFrequency.weekly => loc.freqWeekly,
      };
}

class _IncomeStep extends StatelessWidget {
  const _IncomeStep({
    required this.controller,
    required this.incomeType,
    required this.allowanceSubType,
    required this.incomeFrequency,
    required this.onSelectIncomeType,
    required this.onSelectAllowanceSubType,
    required this.onSelectFrequency,
    required this.onChanged,
  });

  final TextEditingController controller;
  final IncomeType incomeType;
  final AllowanceSubType allowanceSubType;
  final IncomeFrequency incomeFrequency;
  final ValueChanged<IncomeType> onSelectIncomeType;
  final ValueChanged<AllowanceSubType> onSelectAllowanceSubType;
  final ValueChanged<IncomeFrequency> onSelectFrequency;
  final VoidCallback onChanged;

  bool get _usesFrequency =>
      incomeType == IncomeType.fixed ||
      (incomeType == IncomeType.allowance &&
          allowanceSubType == AllowanceSubType.regular);

  (String, String?) _questionFor(AppLocalizations loc) => switch (incomeType) {
        IncomeType.fixed => (loc.questionIncomeFixed, loc.questionIncomeFixedSub),
        IncomeType.irregular =>
          (loc.questionIncomeVariable, loc.questionIncomeVariableSub),
        IncomeType.allowance => allowanceSubType == AllowanceSubType.irregular
            ? (loc.questionIrregularMinSave, null)
            : (loc.questionIncomeAllowance, null),
      };

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final (question, subtitle) = _questionFor(loc);
    final formatter = NumberFormat('#,###');
    final amount = double.tryParse(controller.text.replaceAll(',', '')) ?? 0;
    final showConversion =
        _usesFrequency && incomeFrequency != IncomeFrequency.monthly && amount > 0;
    final monthlyEquivalent = incomeFrequency.monthlyEquivalent(amount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final type in IncomeType.values)
              JuiceChoiceChip(
                label: type.label(loc),
                selected: incomeType == type,
                onTap: () => onSelectIncomeType(type),
              ),
          ],
        ),
        if (incomeType == IncomeType.allowance) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              JuiceChoiceChip(
                label: loc.subAllowanceRegular,
                selected: allowanceSubType == AllowanceSubType.regular,
                onTap: () => onSelectAllowanceSubType(AllowanceSubType.regular),
              ),
              JuiceChoiceChip(
                label: loc.subAllowanceIrregular,
                selected: allowanceSubType == AllowanceSubType.irregular,
                onTap: () => onSelectAllowanceSubType(AllowanceSubType.irregular),
              ),
            ],
          ),
        ],
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: _StepHeader(
            key: ValueKey('$incomeType-$allowanceSubType'),
            emoji: '💰',
            question: question,
            subtitle: subtitle,
          ),
        ),
        if (_usesFrequency) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final freq in IncomeFrequency.values)
                JuiceChoiceChip(
                  label: freq.label(loc),
                  selected: incomeFrequency == freq,
                  onTap: () => onSelectFrequency(freq),
                ),
            ],
          ),
          const SizedBox(height: 16),
        ],
        TextField(
          controller: controller,
          autofocus: true,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [ThousandsSeparatorInputFormatter()],
          style: Theme.of(context).textTheme.headlineMedium,
          decoration: InputDecoration(
              hintText: '0', suffixText: loc.wonSuffixSpaced, border: InputBorder.none),
          onChanged: (_) => onChanged(),
        ),
        if (showConversion) ...[
          const SizedBox(height: 8),
          Text(
            loc.freqConversionCaption(
              formatter.format(monthlyEquivalent),
              formatter.format(monthlyEquivalent / 30 * 7),
            ),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}

class _WeeklyExpenseStep extends StatelessWidget {
  const _WeeklyExpenseStep({
    required this.controller,
    required this.presets,
    required this.onChanged,
  });

  final TextEditingController controller;
  final List<int> presets;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final formatter = NumberFormat('#,###');
    final current = double.tryParse(controller.text.replaceAll(',', ''));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StepHeader(emoji: '🛒', question: loc.questionWeeklyExpenseVariable),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final preset in presets)
              JuiceChoiceChip(
                label: formatter.format(preset),
                selected: current == preset.toDouble(),
                onTap: () {
                  controller.text = formatter.format(preset);
                  onChanged();
                },
              ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          controller: controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [ThousandsSeparatorInputFormatter()],
          style: Theme.of(context).textTheme.headlineSmall,
          decoration: InputDecoration(hintText: '0', suffixText: loc.wonUnit),
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

  String _presetLabel(AppLocalizations loc, int months) => months < 12
      ? loc.monthsPresetLabel(months)
      : loc.yearsPresetLabel(months ~/ 12);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StepHeader(emoji: '🎯', question: loc.goalStepQuestion),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final months in presets)
              JuiceChoiceChip(
                label: _presetLabel(loc, months),
                selected: !customDuration && selectedPreset == months,
                onTap: () => onSelectPreset(months),
              ),
            JuiceChoiceChip(
              label: loc.customInputLabel,
              selected: customDuration,
              onTap: onSelectCustom,
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
                  decoration: InputDecoration(labelText: loc.yearsFieldLabel),
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
                  decoration: InputDecoration(labelText: loc.monthsFieldLabel),
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
          decoration: InputDecoration(
              labelText: loc.goalAmountFieldLabel, suffixText: loc.wonUnit),
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
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StepHeader(
          emoji: '🏠',
          question: loc.fixedExpenseStepQuestion,
          subtitle: loc.fixedExpenseStepSubtitle,
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
                    decoration: InputDecoration(hintText: loc.itemNameHint),
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
                        InputDecoration(hintText: '0', suffixText: loc.wonUnit),
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
            label: Text(loc.addItemButton)),
      ],
    );
  }
}

class _PraiseCard extends StatelessWidget {
  const _PraiseCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Text(
        message,
        style: theme.textTheme.titleMedium
            ?.copyWith(fontWeight: FontWeight.w700, height: 1.5),
      ),
    );
  }
}

class _ResultStep extends StatelessWidget {
  const _ResultStep({required this.plan});

  final SavingsPlan plan;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final formatter = NumberFormat('#,###');
    final theme = Theme.of(context);

    if (plan.incomeType == IncomeType.irregular) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StepHeader(emoji: '🍹', question: loc.resultStepQuestion),
          _PraiseCard(
              message: loc.praiseVariablePlan(formatter.format(plan.goalAmount ?? 0))),
        ],
      );
    }

    final isAllowanceIrregular = plan.incomeType == IncomeType.allowance &&
        plan.allowanceSubType == AllowanceSubType.irregular;
    if (isAllowanceIrregular) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StepHeader(emoji: '🍹', question: loc.resultStepQuestion),
          _PraiseCard(
              message: loc.praiseAllowancePlan(formatter.format(plan.goalAmount ?? 0))),
        ],
      );
    }

    final monthly = plan.monthlyAvailable;
    final isNegative = monthly != null && monthly < 0;
    final isAllowance = plan.incomeType == IncomeType.allowance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StepHeader(emoji: '🍹', question: loc.resultStepQuestion),
        if (monthly == null || isNegative)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              isAllowance ? loc.guideExtendGoalPeriod : loc.resultNegativeMessage,
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
                  loc.resultBreakdownLine(formatter.format(plan.monthlyIncome),
                      formatter.format(plan.fixedExpenseTotal)),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Text.rich(
                  TextSpan(
                    style: theme.textTheme.titleLarge,
                    children: [
                      TextSpan(text: loc.resultWeeklyPrefix),
                      TextSpan(
                        text: '${formatter.format(plan.weeklyAvailable)} mL',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(text: loc.resultWeeklySuffix),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  loc.resultDailyMonthlyLine(formatter.format(plan.dailyAvailable),
                      formatter.format(monthly)),
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
