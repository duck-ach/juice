import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/edit_delete_slidable.dart';
import '../../data/models/card_item.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/card_provider.dart';
import 'widgets/add_card_dialog.dart';

/// 내 카드 관리 화면. UI는 카테고리 관리 화면(ReorderableListView + Slidable)과 동일한 구조.
class CardManagementScreen extends ConsumerWidget {
  const CardManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final cards = ref.watch(cardProvider);

    return Scaffold(
      appBar: AppBar(title: Text(loc.cardManagementTitle)),
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
                  subtitle: Text(card.subtitleLabel(loc)),
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
    final loc = AppLocalizations.of(context)!;
    if (card.isDefault) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(loc.defaultCardUndeletable)));
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(loc.cardDeleteTitle),
        content: Text(loc.cardDeleteConfirm(card.name)),
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

    if (confirmed == true) {
      await ref.read(cardProvider.notifier).remove(card.id);
    }
  }
}
