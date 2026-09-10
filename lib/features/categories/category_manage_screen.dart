import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/edit_delete_slidable.dart';
import '../../data/models/category.dart';
import '../../providers/category_provider.dart';
import 'widgets/add_category_dialog.dart';

class CategoryManageScreen extends ConsumerWidget {
  const CategoryManageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('카테고리 관리')),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 96),
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
            padding: const EdgeInsets.only(bottom: 8), // 여백을 Slidable 바깥으로 이동
            child: EditDeleteSlidable(
              key: ValueKey(category.id),
              onEdit: () => showEditCategorySheet(context, ref, category),
              onDelete: () => _confirmDelete(context, ref, category),
              child: Card(
                margin: EdgeInsets.zero, // Card 마진을 0으로 설정
                child: ListTile(
                  onTap: () => showEditCategorySheet(context, ref, category),
                  leading: CircleAvatar(
                    backgroundColor: color.withValues(alpha: 0.18),
                    child: Icon(
                      IconData(category.iconCodePoint,
                          fontFamily:
                              category.iconFontFamily ?? 'MaterialIcons'),
                      color: color,
                    ),
                  ),
                  title: Text(category.name),
                  subtitle: Text(category.description,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: ReorderableDragStartListener(
                    index: index,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                      child: Icon(Icons.drag_handle),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'category_manage_fab',
        onPressed: () => showAddCategorySheet(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  /// 기본 카테고리는 삭제할 수 없음. 커스텀 카테고리는 확인 후 삭제.
  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, Category category) async {
    if (category.isDefault) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(const SnackBar(content: Text('기본 카테고리는 삭제할 수 없어요')));
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('카테고리 삭제'),
        content: Text('\'${category.name}\' 카테고리를 삭제할까요?\n이미 기록된 지출 내역은 유지돼요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(categoryProvider.notifier).remove(category.id);
    }
  }
}
