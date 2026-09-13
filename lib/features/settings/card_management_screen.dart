import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/edit_delete_slidable.dart';
import '../../data/models/card_item.dart';
import '../../providers/card_provider.dart';
import 'widgets/add_card_dialog.dart';

/// 내 카드 관리 화면. UI는 카테고리 관리 화면(ReorderableListView + Slidable)과 동일한 구조.
class CardManagementScreen extends ConsumerWidget {
  const CardManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(cardProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('내 카드 관리')),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 96),
        buildDefaultDragHandles: false,
        itemCount: cards.length,
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) newIndex -= 1;
          final reordered = [...cards];
          final moved = reordered.removeAt(oldIndex);
          reordered.insert(newIndex, moved);
          ref.read(cardProvider.notifier).reorder(reordered);
        },
        itemBuilder: (context, index) {
          final card = cards[index];
          final color = Color(card.colorValue);
          return Padding(
            key: ValueKey(card.id),
            padding: const EdgeInsets.only(bottom: 8),
            child: EditDeleteSlidable(
              key: ValueKey(card.id),
              onEdit: () => showEditCardSheet(context, ref, card),
              onDelete: () => _confirmDelete(context, ref, card),
              child: Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  onTap: () => showEditCardSheet(context, ref, card),
                  leading: CircleAvatar(
                    backgroundColor: color.withValues(alpha: 0.18),
                    child: Icon(Icons.credit_card, color: color),
                  ),
                  title: Text(card.name,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text(card.subtitleLabel),
                  trailing: ReorderableDragStartListener(
                    index: index,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                      child: Icon(Icons.reorder),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'card_manage_fab',
        onPressed: () => showAddCardSheet(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  /// 기본 카드는 삭제할 수 없음. 커스텀 카드는 확인 후 삭제.
  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, CardItem card) async {
    if (card.isDefault) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(const SnackBar(content: Text('기본 카드는 삭제할 수 없어요')));
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('카드 삭제'),
        content: Text('\'${card.name}\' 카드를 삭제할까요?\n이미 기록된 지출 내역은 유지돼요.'),
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
      await ref.read(cardProvider.notifier).remove(card.id);
    }
  }
}
