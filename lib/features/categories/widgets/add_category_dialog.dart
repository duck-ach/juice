import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/category_assets.dart';
import '../../../core/utils/color_argb.dart';
import '../../../data/models/category.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/juice_theme_provider.dart';

/// 새 커스텀 카테고리를 생성하는 바텀시트. 성공 시 새로 생성된 카테고리의 id를 반환, 취소 시 null.
/// [type]에 따라 지출/수입 카테고리 중 어느 쪽으로 생성할지, 아이콘 추천 세트도 달라진다.
Future<String?> showAddCategorySheet(BuildContext context, WidgetRef ref,
    {CategoryType type = CategoryType.expense}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _CategoryEditSheet(type: type),
  );
}

/// 기존 카테고리(기본 카테고리 포함)를 수정하는 바텀시트.
Future<void> showEditCategorySheet(
    BuildContext context, WidgetRef ref, Category category) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _CategoryEditSheet(editing: category),
  );
}

class _CategoryEditSheet extends ConsumerStatefulWidget {
  const _CategoryEditSheet({this.editing, this.type = CategoryType.expense});

  final Category? editing;

  /// 새로 만들 카테고리의 종류. [editing]이 주어지면 무시되고 그 카테고리의 종류를 따른다
  /// (수정 화면에서는 카테고리 종류 자체를 바꿀 수 없음).
  final CategoryType type;

  @override
  ConsumerState<_CategoryEditSheet> createState() => _CategoryEditSheetState();
}

class _CategoryEditSheetState extends ConsumerState<_CategoryEditSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late Color _selectedColor;
  late IconData _selectedIcon;

  bool get _isEditing => widget.editing != null;
  CategoryType get _type => widget.editing?.type ?? widget.type;
  List<IconData> get _iconChoices => switch (_type) {
        CategoryType.income => CategoryAssets.incomeIcons,
        CategoryType.savings => CategoryAssets.savingsIcons,
        CategoryType.expense => CategoryAssets.icons,
      };

  bool _descriptionInitialized = false;

  /// 커스텀 카테고리 기본 설명 문구. 현재 주스 테마의 대표 과일 이모지를 붙여 반환한다.
  String _defaultDescription(AppLocalizations loc) =>
      '${loc.categoryDefaultDescription} ${ref.read(resolvedJuiceThemeProvider).emoji}';

  @override
  void initState() {
    super.initState();
    final editing = widget.editing;
    _nameController = TextEditingController(text: editing?.name ?? '');
    _descriptionController = TextEditingController(text: editing?.description);
    _selectedColor = editing != null
        ? Color(editing.colorValue)
        : CategoryAssets.palette.first;
    _selectedIcon = editing != null
        ? IconData(editing.iconCodePoint,
            fontFamily: editing.iconFontFamily ?? 'MaterialIcons')
        : _iconChoices.first;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_descriptionInitialized && widget.editing == null) {
      _descriptionController.text =
          _defaultDescription(AppLocalizations.of(context)!);
    }
    _descriptionInitialized = true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final loc = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    final description = _descriptionController.text.trim().isEmpty
        ? _defaultDescription(loc)
        : _descriptionController.text.trim();

    final notifier = ref.read(categoryProvider.notifier);
    if (_isEditing) {
      final editing = widget.editing!;
      editing.name = name;
      editing.description = description;
      editing.colorValue = _selectedColor.toArgbInt();
      editing.iconCodePoint = _selectedIcon.codePoint;
      editing.iconFontFamily = _selectedIcon.fontFamily;
      await notifier.update(editing);
      if (mounted) Navigator.of(context).pop();
    } else {
      final newId = await notifier.addCustom(
        name: name,
        colorValue: _selectedColor.toArgbInt(),
        iconCodePoint: _selectedIcon.codePoint,
        iconFontFamily: _selectedIcon.fontFamily,
        description: description,
        type: _type,
      );
      if (mounted) Navigator.of(context).pop(newId);
    }
  }

  Future<void> _delete() async {
    final loc = AppLocalizations.of(context)!;
    final editing = widget.editing;
    if (editing == null || editing.isDefault) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(loc.categoryDeleteTitle),
        content: Text(loc.categoryDeleteConfirm(editing.getLocalizedName(context))),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(loc.commonCancel)),
          FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(loc.commonDelete)),
        ],
      ),
    );
    if (confirmed != true) return;
    final result = await ref.read(categoryProvider.notifier).remove(editing.id);
    if (!mounted) return;
    if (result == CategoryRemoveResult.inUse) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(loc.categoryInUseMessage)));
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
                      _isEditing
                          ? loc.categoryEditTitle
                          : loc.categoryAddTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  if (_isEditing && !widget.editing!.isDefault)
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      tooltip: loc.commonDelete,
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
                  child: Icon(_selectedIcon, color: Colors.white, size: 30),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                autofocus: !_isEditing,
                decoration: InputDecoration(labelText: loc.categoryNameLabel),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                decoration:
                    InputDecoration(labelText: loc.categoryDescriptionLabel),
              ),
              const SizedBox(height: 16),
              Text(loc.colorLabel, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: CategoryAssets.palette.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final c = CategoryAssets.palette[index];
                    final selected = c == _selectedColor;
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
              Text(loc.iconLabel, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _iconChoices.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final icon = _iconChoices[index];
                    final selected = icon.codePoint == _selectedIcon.codePoint;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedIcon = icon),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: selected
                              ? _selectedColor
                              : _selectedColor.withValues(alpha: 0.14),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon,
                            size: 22,
                            color: selected ? Colors.white : _selectedColor),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 52,
                child: FilledButton(
                    onPressed: _save,
                    child: Text(_isEditing ? loc.commonSave : loc.commonAdd)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
