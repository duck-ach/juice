import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/edit_delete_slidable.dart';
import '../../core/widgets/juice_segmented_tab.dart';
import '../../data/models/category.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/category_provider.dart';
import 'widgets/add_category_dialog.dart';

class CategoryManageScreen extends ConsumerStatefulWidget {
  const CategoryManageScreen({super.key});

  @override
  ConsumerState<CategoryManageScreen> createState() =>
      _CategoryManageScreenState();
}

class _CategoryManageScreenState extends ConsumerState<CategoryManageScreen> {
  CategoryType _type = CategoryType.expense;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final categories = ref.watch(switch (_type) {
      CategoryType.expense => expenseCategoriesProvider,
      CategoryType.income => incomeCategoriesProvider,
      CategoryType.savings => savingsCategoriesProvider,
    });

    return Scaffold(
      appBar: AppBar(title: Text(loc.categoryManageTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
            child: JuiceSegmentedTab(
              items: [
                loc.expenseCategoryTab,
                loc.incomeCategoryTab,
                loc.savingsCategoryTab,
              ],
              selectedIndex: CategoryType.values.indexOf(_type),
              onTabChanged: (index) =>
                  setState(() => _type = CategoryType.values[index]),
            ),
          ),
          Expanded(
            child: ReorderableListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 96),
              buildDefaultDragHandles: false,
              itemCount: categories.length,
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) newIndex -= 1;
                final reordered = [...categories];
                final moved = reordered.removeAt(oldIndex);
                reordered.insert(newIndex, moved);
                ref.read(categoryProvider.notifier).reorder(reordered);
              },
              itemBuilder: (context, index) {
                final category = categories[index];
                final color = Color(category.colorValue);
                return Padding(
                  key: ValueKey(category.id),
                  padding: const EdgeInsets.only(bottom: 8),
                  child: EditDeleteSlidable(
                    key: ValueKey(category.id),
                    onEdit: () => showEditCategorySheet(context, ref, category),
                    onDelete: () => _confirmDelete(context, ref, category),
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        onTap: () =>
                            showEditCategorySheet(context, ref, category),
                        leading: CircleAvatar(
                          backgroundColor: color.withValues(alpha: 0.18),
                          child: Icon(
                            IconData(category.iconCodePoint,
                                fontFamily:
                                    category.iconFontFamily ?? 'MaterialIcons'),
                            color: color,
                          ),
                        ),
                        title: Text(category.getLocalizedName(context)),
                        subtitle: Text(category.getLocalizedDescription(context),
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        trailing: ReorderableDragStartListener(
                          index: index,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 12),
                            child: Icon(Icons.drag_handle),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'category_manage_fab',
        onPressed: () => showAddCategorySheet(context, ref, type: _type),
        child: const Icon(Icons.add),
      ),
    );
  }

  /// 기본 카테고리는 삭제할 수 없음. 수입 카테고리는 사용 중인 내역이 있으면 삭제를 막는다.
  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, Category category) async {
    final loc = AppLocalizations.of(context)!;
    if (category.isDefault) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(loc.defaultCategoryUndeletable)));
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(loc.categoryDeleteTitle),
        content: Text(loc.categoryDeleteConfirm(category.getLocalizedName(context))),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(loc.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(loc.commonDelete),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    final result =
        await ref.read(categoryProvider.notifier).remove(category.id);
    if (result == CategoryRemoveResult.inUse && context.mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(loc.categoryInUseMessage)));
    }
  }
}
