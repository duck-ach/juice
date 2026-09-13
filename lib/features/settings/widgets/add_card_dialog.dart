import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/category_assets.dart';
import '../../../data/models/card_item.dart';
import '../../../providers/card_provider.dart';

/// 새 카드를 생성하는 바텀시트. 성공 시 새로 생성된 카드의 id를 반환, 취소 시 null.
Future<String?> showAddCardSheet(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _CardEditSheet(),
  );
}

/// 기존 카드(기본 카드 포함)를 수정하는 바텀시트.
Future<void> showEditCardSheet(
    BuildContext context, WidgetRef ref, CardItem card) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _CardEditSheet(editing: card),
  );
}

class _CardEditSheet extends ConsumerStatefulWidget {
  const _CardEditSheet({this.editing});

  final CardItem? editing;

  @override
  ConsumerState<_CardEditSheet> createState() => _CardEditSheetState();
}

class _CardEditSheetState extends ConsumerState<_CardEditSheet> {
  late final TextEditingController _nameController;
  late Color _selectedColor;
  late CardType _selectedType;

  bool get _isEditing => widget.editing != null;

  @override
  void initState() {
    super.initState();
    final editing = widget.editing;
    _nameController = TextEditingController(text: editing?.name ?? '');
    _selectedColor =
        editing != null ? Color(editing.colorValue) : CategoryAssets.palette.first;
    _selectedType = editing?.type ?? CardType.check;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final notifier = ref.read(cardProvider.notifier);
    if (_isEditing) {
      final editing = widget.editing!;
      editing.name = name;
      editing.colorValue = _selectedColor.value;
      editing.type = _selectedType;
      editing.excludeFromJuice = _selectedType == CardType.corporate;
      await notifier.update(editing);
      if (mounted) Navigator.of(context).pop();
    } else {
      final newId = await notifier.addCustom(
        name: name,
        type: _selectedType,
        colorValue: _selectedColor.value,
      );
      if (mounted) Navigator.of(context).pop(newId);
    }
  }

  Future<void> _delete() async {
    final editing = widget.editing;
    if (editing == null || editing.isDefault) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('카드 삭제'),
        content: Text('\'${editing.name}\' 카드를 삭제할까요?\n이미 기록된 지출 내역은 유지돼요.'),
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
    await ref.read(cardProvider.notifier).remove(editing.id);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85),
        child: SingleChildScrollView(
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
                    child: Text(
                      _isEditing ? '카드 수정' : '카드 추가',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  if (_isEditing && !widget.editing!.isDefault)
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      tooltip: '삭제',
                      onPressed: _delete,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                      color: _selectedColor, shape: BoxShape.circle),
                  child: const Icon(Icons.credit_card,
                      color: Colors.white, size: 30),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                autofocus: !_isEditing,
                decoration: const InputDecoration(labelText: '카드 이름'),
              ),
              const SizedBox(height: 16),
              Text('카드 종류', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              SegmentedButton<CardType>(
                segments: CardType.values
                    .map((t) => ButtonSegment(value: t, label: Text(t.label)))
                    .toList(),
                selected: {_selectedType},
                onSelectionChanged: (selection) =>
                    setState(() => _selectedType = selection.first),
              ),
              const SizedBox(height: 16),
              Text('색상', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: CategoryAssets.palette.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final c = CategoryAssets.palette[index];
                    final selected = c.value == _selectedColor.value;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedColor = c),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.circle,
                          border: selected
                              ? Border.all(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  width: 2)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 52,
                child: FilledButton(
                    onPressed: _save, child: Text(_isEditing ? '저장' : '추가')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
