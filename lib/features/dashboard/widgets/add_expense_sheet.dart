import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils/korean_josa.dart';
import '../../../core/utils/thousands_formatter.dart';
import '../../../data/models/category.dart';
import '../../../data/models/expense.dart';
import '../../../data/models/income_category.dart';
import '../../../data/models/payment_method.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/expense_provider.dart';
import '../../categories/widgets/add_category_dialog.dart';

const _installmentPresets = [1, 2, 3, 6, 12];

/// 지출 추가/수정 바텀시트.
/// [editingExpense]가 주어지면 수정 모드(저장/삭제)로, 아니면 새 지출 추가 모드로 연다.
/// [initialDate]는 추가 모드에서 기본 날짜(예: 캘린더에서 선택한 날짜)를 지정할 때 사용.
Future<void> showAddExpenseSheet(
  BuildContext context, {
  Expense? editingExpense,
  DateTime? initialDate,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AddExpenseSheet(
        editingExpense: editingExpense, initialDate: initialDate),
  );
}

class AddExpenseSheet extends ConsumerStatefulWidget {
  const AddExpenseSheet({super.key, this.editingExpense, this.initialDate});

  final Expense? editingExpense;
  final DateTime? initialDate;

  @override
  ConsumerState<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<AddExpenseSheet> {
  late final TextEditingController _amountController;
  late final TextEditingController _memoController;
  late final TextEditingController _customInstallmentController;
  late final TextEditingController _splitTotalController;
  String? _selectedCategoryId;
  bool _isFixed = false;
  bool _isIncome = false;
  late DateTime _selectedDate;
  PaymentMethod _paymentMethod = PaymentMethod.checkCard;
  int _installmentMonths = 1;
  bool _customInstallment = false;
  int _splitPeopleCount = 2;
  String? _autoSplitMemoTag;

  bool get _isEditing => widget.editingExpense != null;

  @override
  void initState() {
    super.initState();
    final editing = widget.editingExpense;
    _amountController = TextEditingController(
      text: editing != null ? NumberFormat('#,###').format(editing.amount) : '',
    );
    _amountController.addListener(() => setState(() {}));
    _memoController = TextEditingController(text: editing?.memo ?? '');
    _selectedCategoryId = editing?.categoryId;
    _isFixed = editing?.isFixed ?? false;
    _isIncome = editing?.isIncome ?? false;
    _selectedDate = editing?.date ?? widget.initialDate ?? DateTime.now();
    _paymentMethod = editing?.paymentMethod ?? PaymentMethod.checkCard;
    _installmentMonths = editing?.installmentMonths ?? 1;
    _customInstallment = !_installmentPresets.contains(_installmentMonths);
    _customInstallmentController = TextEditingController(
        text: _customInstallment ? '$_installmentMonths' : '');
    _splitTotalController = TextEditingController();
  }

  void _setIncome(bool isIncome) {
    if (isIncome == _isIncome) return;
    setState(() {
      _isIncome = isIncome;
      _selectedCategoryId = null;
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _memoController.dispose();
    _customInstallmentController.dispose();
    _splitTotalController.dispose();
    super.dispose();
  }

  /// 더치페이 총액/인원 수가 바뀔 때마다 "내가 낼 주스" 금액을 메인 인풋에 자동 반영하고,
  /// 메모가 비어있거나 이전 자동 태그 그대로면 새 태그로 갱신한다.
  void _onSplitBillInputsChanged() {
    final total =
        double.tryParse(_splitTotalController.text.replaceAll(',', ''));
    if (total == null || total <= 0 || _splitPeopleCount < 2) return;
    final formatter = NumberFormat('#,###');
    final perPerson = (total / _splitPeopleCount).round();
    final formattedAmount = formatter.format(perPerson);
    if (_amountController.text != formattedAmount) {
      _amountController.text = formattedAmount;
    }
    final tag = '(총 ${formatter.format(total)}mL / $_splitPeopleCount명 더치페이)';
    final currentMemo = _memoController.text.trim();
    if (currentMemo.isEmpty || currentMemo == _autoSplitMemoTag) {
      _memoController.text = tag;
    }
    _autoSplitMemoTag = tag;
  }

  String get _splitBillHint {
    final total =
        double.tryParse(_splitTotalController.text.replaceAll(',', ''));
    if (total == null || total <= 0) return '';
    final formatter = NumberFormat('#,###');
    final perPerson = (total / _splitPeopleCount).round();
    return '내가 낼 주스: ${formatter.format(perPerson)} mL '
        '(총 ${formatter.format(total)} mL ÷ $_splitPeopleCount명)';
  }

  String get _installmentHint {
    if (_installmentMonths <= 1) return '';
    final amount = double.tryParse(_amountController.text.replaceAll(',', ''));
    if (amount == null || amount <= 0) return '';
    final perMonth = (amount / _installmentMonths).round();
    return '매달 ${NumberFormat('#,###').format(perMonth)} mL씩 '
        '$_installmentMonths회 분할 반영돼요';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _submit() async {
    final amount = double.tryParse(_amountController.text.replaceAll(',', ''));
    if (amount == null || amount <= 0 || _selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('금액과 카테고리를 확인해주세요')),
      );
      return;
    }

    final categoryName = _isIncome
        ? (findIncomeCategory(_selectedCategoryId!)?.name ?? '수입')
        : ref
            .read(categoryProvider)
            .firstWhere((c) => c.id == _selectedCategoryId)
            .name;
    final memo = _memoController.text.trim().isEmpty
        ? null
        : _memoController.text.trim();
    final isNewInstallment = !_isEditing &&
        !_isIncome &&
        _paymentMethod == PaymentMethod.creditCard &&
        _installmentMonths > 1;

    if (isNewInstallment) {
      final base = Expense(
        id: const Uuid().v4(),
        amount: amount,
        categoryId: _selectedCategoryId!,
        date: _selectedDate,
        memo: memo,
        isFixed: _isFixed,
      );
      await ref
          .read(expenseProvider.notifier)
          .upsertInstallment(base, _installmentMonths);
    } else {
      final expense = Expense(
        id: widget.editingExpense?.id ?? const Uuid().v4(),
        amount: amount,
        categoryId: _selectedCategoryId!,
        date: _selectedDate,
        memo: memo,
        isFixed: _isIncome ? false : _isFixed,
        isIncome: _isIncome,
        createdAt: widget.editingExpense?.createdAt,
        paymentMethod: _isIncome ? PaymentMethod.checkCard : _paymentMethod,
        installmentMonths: widget.editingExpense?.installmentMonths ?? 1,
        currentInstallmentIndex:
            widget.editingExpense?.currentInstallmentIndex ?? 1,
        installmentGroupId: widget.editingExpense?.installmentGroupId,
      );
      await ref.read(expenseProvider.notifier).upsert(expense);
    }

    if (!mounted) return;
    if (!_isEditing) {
      final formatter = NumberFormat('#,###');
      final message = _isIncome
          ? '$categoryName${roJosa(categoryName)} ${formatter.format(amount)} mL가 들어왔어요! 💰'
          : '$categoryName${roJosa(categoryName)} ${formatter.format(amount)} mL를 마셨어요! 🍊';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
    Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    final editing = widget.editingExpense;
    if (editing == null) return;
    final label = editing.isIncome ? '수입' : '지출';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('$label 삭제'),
        content: Text('이 $label 내역을 삭제할까요?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('취소')),
          FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('삭제')),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(expenseProvider.notifier).delete(editing.id);
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _openAddCategoryDialog() async {
    final newCategoryId = await showAddCategorySheet(context, ref);
    if (newCategoryId != null) {
      setState(() => _selectedCategoryId = newCategoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    if (_isIncome) {
      _selectedCategoryId ??=
          incomeCategories.isNotEmpty ? incomeCategories.first.id : null;
    } else {
      _selectedCategoryId ??=
          categories.isNotEmpty ? categories.first.id : null;
    }
    final typeLabel = _isIncome ? '수입' : '지출';

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _isEditing ? '$typeLabel 수정' : '$typeLabel 추가',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    if (_isEditing)
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        tooltip: '삭제',
                        onPressed: _delete,
                      ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),
                        SegmentedButton<bool>(
                          segments: const [
                            ButtonSegment(value: false, label: Text('지출')),
                            ButtonSegment(value: true, label: Text('수입')),
                          ],
                          selected: {_isIncome},
                          onSelectionChanged: (selection) =>
                              _setIncome(selection.first),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _amountController,
                          autofocus: false,
                          readOnly: !_isEditing &&
                              _paymentMethod == PaymentMethod.splitBill,
                          keyboardType: TextInputType.number,
                          inputFormatters: [ThousandsSeparatorInputFormatter()],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                          decoration: InputDecoration(
                            hintText: '0',
                            suffixText: ' mL',
                            border: InputBorder.none,
                            helperText: !_isEditing &&
                                    _paymentMethod == PaymentMethod.splitBill
                                ? '아래에서 총 금액과 인원 수를 입력하면 자동으로 채워져요'
                                : null,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 86,
                          child: _isIncome
                              ? ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: incomeCategories.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 8),
                                  itemBuilder: (context, index) {
                                    final category = incomeCategories[index];
                                    return _IncomeCategoryChip(
                                      category: category,
                                      selected:
                                          category.id == _selectedCategoryId,
                                      onTap: () => setState(() =>
                                          _selectedCategoryId = category.id),
                                    );
                                  },
                                )
                              : ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categories.length + 1,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 8),
                                  itemBuilder: (context, index) {
                                    if (index == categories.length) {
                                      return _AddCategoryChip(
                                          onTap: _openAddCategoryDialog);
                                    }
                                    final category = categories[index];
                                    return _CategoryChip(
                                      category: category,
                                      selected:
                                          category.id == _selectedCategoryId,
                                      onTap: () => setState(() =>
                                          _selectedCategoryId = category.id),
                                    );
                                  },
                                ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: _pickDate,
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.event_outlined, size: 20),
                                const SizedBox(width: 10),
                                Text(DateFormat('yyyy.M.d (E)', 'ko')
                                    .format(_selectedDate)),
                                const Spacer(),
                                const Icon(Icons.chevron_right, size: 18),
                              ],
                            ),
                          ),
                        ),
                        if (!_isIncome) ...[
                          const SizedBox(height: 8),
                          SegmentedButton<PaymentMethod>(
                            segments: PaymentMethod.values
                                .map((m) => ButtonSegment(
                                    value: m, label: Text(m.label)))
                                .toList(),
                            selected: {_paymentMethod},
                            onSelectionChanged: (selection) => setState(
                                () => _paymentMethod = selection.first),
                          ),
                          if (_isEditing &&
                              widget.editingExpense!.isInstallment) ...[
                            const SizedBox(height: 4),
                            Text(
                              '할부 ${widget.editingExpense!.currentInstallmentIndex}'
                              '/${widget.editingExpense!.installmentMonths}회차 — '
                              '다른 회차 금액은 함께 바뀌지 않아요',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                          if (_paymentMethod == PaymentMethod.creditCard &&
                              !_isEditing) ...[
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                for (final m in _installmentPresets)
                                  ChoiceChip(
                                    label: Text(m == 1 ? '일시불' : '$m개월'),
                                    selected: !_customInstallment &&
                                        _installmentMonths == m,
                                    onSelected: (_) => setState(() {
                                      _customInstallment = false;
                                      _installmentMonths = m;
                                    }),
                                  ),
                                ChoiceChip(
                                  label: const Text('직접입력'),
                                  selected: _customInstallment,
                                  onSelected: (_) => setState(() {
                                    _customInstallment = true;
                                    _installmentMonths = int.tryParse(
                                            _customInstallmentController
                                                .text) ??
                                        2;
                                  }),
                                ),
                              ],
                            ),
                            if (_customInstallment) ...[
                              const SizedBox(height: 8),
                              TextField(
                                controller: _customInstallmentController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                    hintText: '개월 수 (2~24)'),
                                onChanged: (v) {
                                  final parsed = int.tryParse(v);
                                  setState(() => _installmentMonths =
                                      parsed == null ? 2 : parsed.clamp(2, 24));
                                },
                              ),
                            ],
                            if (_installmentHint.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                _installmentHint,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                            ],
                          ],
                          if (_paymentMethod == PaymentMethod.splitBill &&
                              !_isEditing) ...[
                            const SizedBox(height: 8),
                            TextField(
                              controller: _splitTotalController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                ThousandsSeparatorInputFormatter()
                              ],
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  labelText: '총 결제 금액', suffixText: ' mL'),
                              onChanged: (_) =>
                                  setState(_onSplitBillInputsChanged),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text('함께한 인원 수',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: _splitPeopleCount > 2
                                      ? () => setState(() {
                                            _splitPeopleCount--;
                                            _onSplitBillInputsChanged();
                                          })
                                      : null,
                                ),
                                SizedBox(
                                  width: 48,
                                  child: Text('$_splitPeopleCount명',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => setState(() {
                                    _splitPeopleCount++;
                                    _onSplitBillInputsChanged();
                                  }),
                                ),
                              ],
                            ),
                            if (_splitBillHint.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                _splitBillHint,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                            ],
                          ],
                        ],
                        const SizedBox(height: 8),
                        TextField(
                          controller: _memoController,
                          decoration:
                              const InputDecoration(hintText: '메모 (선택)'),
                        ),
                        if (!_isIncome)
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: _isFixed,
                            onChanged: (v) =>
                                setState(() => _isFixed = v ?? false),
                            title: const Text('고정지출로 제외'),
                            subtitle:
                                const Text('월세, 보험료 등 — 주스 게이지에 반영되지 않아요'),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 52,
                  child: FilledButton(
                      onPressed: _submit,
                      child: Text(_isEditing ? '저장' : '추가')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IncomeCategoryChip extends StatelessWidget {
  const _IncomeCategoryChip(
      {required this.category, required this.selected, required this.onTap});

  final IncomeCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: selected ? 1 : 0.18),
                shape: BoxShape.circle,
                border: selected
                    ? Border.all(color: category.color, width: 2)
                    : null,
              ),
              child: Icon(category.icon,
                  color: selected ? Colors.white : category.color),
            ),
            const SizedBox(height: 4),
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip(
      {required this.category, required this.selected, required this.onTap});

  final Category category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = Color(category.colorValue);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withValues(alpha: selected ? 1 : 0.18),
                shape: BoxShape.circle,
                border: selected ? Border.all(color: color, width: 2) : null,
              ),
              child: Icon(
                IconData(category.iconCodePoint,
                    fontFamily: category.iconFontFamily ?? 'MaterialIcons'),
                color: selected ? Colors.white : color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddCategoryChip extends StatelessWidget {
  const _AddCategoryChip({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    width: 1.5),
              ),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 4),
            Text('추가', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
