import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/category_assets.dart';
import '../../../data/models/category.dart';
import '../../../providers/category_provider.dart';

/// 새 커스텀 카테고리를 생성하는 바텀시트. 성공 시 새로 생성된 카테고리의 id를 반환, 취소 시 null.
Future<String?> showAddCategorySheet(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _CategoryEditSheet(),
  );
}

/// 기존 카테고리(기본 카테고리 포함)를 수정하는 바텀시트.
Future<void> showEditCategorySheet(BuildContext context, WidgetRef ref, Category category) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _CategoryEditSheet(editing: category),
  );
}

class _CategoryEditSheet extends ConsumerStatefulWidget {
  const _CategoryEditSheet({this.editing});

  final Category? editing;

  @override
  ConsumerState<_CategoryEditSheet> createState() => _CategoryEditSheetState();
}

class _CategoryEditSheetState extends ConsumerState<_CategoryEditSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late Color _selectedColor;
  late IconData _selectedIcon;

  bool get _isEditing => widget.editing != null;

  @override
  void initState() {
    super.initState();
    final editing = widget.editing;
    _nameController = TextEditingController(text: editing?.name ?? '');
    _descriptionController = TextEditingController(
      text: editing?.description ?? CategoryAssets.defaultCustomDescription,
    );
    _selectedColor = editing != null ? Color(editing.colorValue) : CategoryAssets.palette.first;
    _selectedIcon = editing != null
        ? IconData(editing.iconCodePoint, fontFamily: editing.iconFontFamily ?? 'MaterialIcons')
        : CategoryAssets.icons.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    final description = _descriptionController.text.trim().isEmpty
        ? CategoryAssets.defaultCustomDescription
        : _descriptionController.text.trim();

    final notifier = ref.read(categoryProvider.notifier);
    if (_isEditing) {
      final editing = widget.editing!;
      editing.name = name;
      editing.description = description;
      editing.colorValue = _selectedColor.value;
      editing.iconCodePoint = _selectedIcon.codePoint;
      editing.iconFontFamily = _selectedIcon.fontFamily;
      await notifier.update(editing);
      if (mounted) Navigator.of(context).pop();
    } else {
      final newId = await notifier.addCustom(
        name: name,
        colorValue: _selectedColor.value,
        iconCodePoint: _selectedIcon.codePoint,
        iconFontFamily: _selectedIcon.fontFamily,
        description: description,
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
        title: const Text('카테고리 삭제'),
        content: Text('\'${editing.name}\' 카테고리를 삭제할까요?\n이미 기록된 지출 내역은 유지돼요.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('취소')),
          FilledButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('삭제')),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(categoryProvider.notifier).remove(editing.id);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
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
                      _isEditing ? '카테고리 수정' : '카테고리 추가',
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
                  decoration: BoxDecoration(color: _selectedColor, shape: BoxShape.circle),
                  child: Icon(_selectedIcon, color: Colors.white, size: 30),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                autofocus: !_isEditing,
                decoration: const InputDecoration(labelText: '카테고리 이름'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: '한 줄 설명'),
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
                              ? Border.all(color: Theme.of(context).colorScheme.onSurface, width: 2)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text('아이콘', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: CategoryAssets.icons.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final icon = CategoryAssets.icons[index];
                    final selected = icon.codePoint == _selectedIcon.codePoint;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedIcon = icon),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: selected ? _selectedColor : _selectedColor.withValues(alpha: 0.14),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: 22, color: selected ? Colors.white : _selectedColor),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 52,
                child: FilledButton(onPressed: _save, child: Text(_isEditing ? '저장' : '추가')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
