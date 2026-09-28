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
        // 드래그 중인 카드의 기본 그림자(Material)는 각진 사각형이라 카드의
        // 둥근 모서리(Card 테마의 borderRadius: 20)와 어긋나 보인다. 카드와
        // 같은 모양으로 직접 그려서 드래그 중에도 라운드가 유지되게 하고,
        // 집어든 느낌을 주려고 애니메이션에 맞춰 살짝 확대 + 그림자를 키운다.
        proxyDecorator: (child, index, animation) {
          return AnimatedBuilder(
            animation: animation,
            child: child,
            builder: (context, child) {
              final t = Curves.easeOut.transform(animation.value);
              return Transform.scale(
                scale: 1.0 + 0.05 * t,
                child: Material(
                  color: Colors.transparent,
                  elevation: 2 + 6 * t,
                  shadowColor: Colors.black38,
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.antiAlias,
                  child: child,
                ),
              );
            },
          );
        },
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
            child: Card(
              margin: EdgeInsets.zero,
              child: Row(
                children: [
                  Expanded(
                    child: EditDeleteSlidable(
                      key: ValueKey(card.id),
                      onEdit: () => showEditCardSheet(context, ref, card),
                      onDelete: () => _confirmDelete(context, ref, card),
                      child: ListTile(
                        onTap: () => showEditCardSheet(context, ref, card),
                        leading: CircleAvatar(
                          backgroundColor: color.withValues(alpha: 0.18),
                          child: Icon(Icons.credit_card, color: color),
                        ),
                        title: Text(card.name,
                            style: const TextStyle(fontWeight: FontWeight.w700)),
                        subtitle: Text(card.subtitleLabel(loc)),
                      ),
                    ),
                  ),
                  // 드래그 핸들은 EditDeleteSlidable(좌우 스와이프) 밖에 둬야 한다 —
                  // 안쪽에 있으면 스와이프 제스처와 드래그 제스처가 서로 우선권을
                  // 다투면서(제스처 아레나 충돌) 드래그 시작이 늦어지고 끊긴다.
                  ReorderableDragStartListener(
                    index: index,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Icon(Icons.drag_handle),
                    ),
                  ),
                ],
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

  /// 기본 카드는 같은 종류(체크/신용)의 다른 카드가 1개 이상 있을 때만 삭제
  /// 가능 — 그 종류의 카드가 아예 사라지는 것을 막는다. 커스텀 카드는 항상
  /// 확인 후 삭제.
  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, CardItem card) async {
    final loc = AppLocalizations.of(context)!;
    if (card.isDefault &&
        !ref
            .read(cardProvider)
            .any((c) => c.id != card.id && c.type == card.type)) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(loc.defaultCardLastOneUndeletable)));
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
