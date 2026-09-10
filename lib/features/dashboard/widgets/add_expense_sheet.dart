import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils/korean_josa.dart';
import '../../../core/utils/thousands_formatter.dart';
import '../../../data/models/category.dart';
import '../../../data/models/expense.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/expense_provider.dart';
import '../../categories/widgets/add_category_dialog.dart';

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
    backgroundColor: Colors.transparent,
    builder: (_) => AddExpenseSheet(editingExpense: editingExpense, initialDate: initialDate),
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
  String? _selectedCategoryId;
  bool _isFixed = false;
  late DateTime _selectedDate;

  bool get _isEditing => widget.editingExpense != null;

  @override
  void initState() {
    super.initState();
    final editing = widget.editingExpense;
    _amountController = TextEditingController(
      text: editing != null ? NumberFormat('#,###').format(editing.amount) : '',
    );
    _memoController = TextEditingController(text: editing?.memo ?? '');
    _selectedCategoryId = editing?.categoryId;
    _isFixed = editing?.isFixed ?? false;
    _selectedDate = editing?.date ?? widget.initialDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _memoController.dispose();
    super.dispose();
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

    final category = ref.read(categoryProvider).firstWhere((c) => c.id == _selectedCategoryId);
    final expense = Expense(
      id: widget.editingExpense?.id ?? const Uuid().v4(),
      amount: amount,
      categoryId: _selectedCategoryId!,
      date: _selectedDate,
      memo: _memoController.text.trim().isEmpty ? null : _memoController.text.trim(),
      isFixed: _isFixed,
      createdAt: widget.editingExpense?.createdAt,
    );
    await ref.read(expenseProvider.notifier).upsert(expense);

    if (!mounted) return;
    if (!_isEditing) {
      final formatter = NumberFormat('#,###');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${category.name}${roJosa(category.name)} ${formatter.format(amount)} mL를 마셨어요! 🍊',
          ),
        ),
      );
    }
    Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    final editing = widget.editingExpense;
    if (editing == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('지출 삭제'),
        content: const Text('이 지출 내역을 삭제할까요?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('취소')),
          FilledButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('삭제')),
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
    _selectedCategoryId ??= categories.isNotEmpty ? categories.first.id : null;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(_isEditing ? '지출 수정' : '지출 추가', style: Theme.of(context).textTheme.titleLarge),
                ),
                if (_isEditing)
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: '삭제',
                    onPressed: _delete,
                  ),
              ],
            ),
            TextField(
              controller: _amountController,
              autofocus: !_isEditing,
              keyboardType: TextInputType.number,
              inputFormatters: [ThousandsSeparatorInputFormatter()],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
              decoration: const InputDecoration(
                hintText: '0',
                suffixText: ' mL',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 86,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  if (index == categories.length) {
                    return _AddCategoryChip(onTap: _openAddCategoryDialog);
                  }
                  final category = categories[index];
                  return _CategoryChip(
                    category: category,
                    selected: category.id == _selectedCategoryId,
                    onTap: () => setState(() => _selectedCategoryId = category.id),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: _pickDate,
              child: Ink(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Theme.of(context).inputDecorationTheme.fillColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.event_outlined, size: 20),
                    const SizedBox(width: 10),
                    Text(DateFormat('yyyy.M.d (E)', 'ko').format(_selectedDate)),
                    const Spacer(),
                    const Icon(Icons.chevron_right, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _memoController,
              decoration: const InputDecoration(hintText: '메모 (선택)'),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: _isFixed,
              onChanged: (v) => setState(() => _isFixed = v ?? false),
              title: const Text('고정지출로 제외'),
              subtitle: const Text('월세, 보험료 등 — 주스 게이지에 반영되지 않아요'),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 52,
              child: FilledButton(onPressed: _submit, child: Text(_isEditing ? '저장' : '추가')),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category, required this.selected, required this.onTap});

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
                IconData(category.iconCodePoint, fontFamily: category.iconFontFamily ?? 'MaterialIcons'),
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
                border: Border.all(color: Theme.of(context).colorScheme.outlineVariant, width: 1.5),
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
