import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../data/models/card_item.dart';
import '../data/repositories/card_repository.dart';

final cardRepositoryProvider =
    Provider<CardRepository>((ref) => CardRepository());

class CardNotifier extends Notifier<List<CardItem>> {
  @override
  List<CardItem> build() => ref.read(cardRepositoryProvider).getAll();

  /// 새 카드를 생성하고 새로 생성된 id를 반환한다.
  Future<String> addCustom({
    required String name,
    required CardType type,
    required int colorValue,
  }) async {
    final repo = ref.read(cardRepositoryProvider);
    final nextOrder = state.isEmpty
        ? 0
        : state.map((c) => c.orderIndex).reduce((a, b) => a > b ? a : b) + 1;
    final card = CardItem(
      id: const Uuid().v4(),
      name: name,
      type: type,
      colorValue: colorValue,
      orderIndex: nextOrder,
    );
    await repo.add(card);
    state = repo.getAll();
    return card.id;
  }

  /// 기존 카드(기본 카드 포함)의 이름/종류/색상을 수정한다.
  Future<void> update(CardItem updated) async {
    final repo = ref.read(cardRepositoryProvider);
    await repo.add(updated);
    state = repo.getAll();
  }

  /// 기본 제공 카드는 삭제할 수 없음.
  Future<void> remove(String id) async {
    final repo = ref.read(cardRepositoryProvider);
    final matches = state.where((c) => c.id == id);
    if (matches.isEmpty || matches.first.isDefault) return;
    await repo.delete(id);
    state = repo.getAll();
  }

  /// 드래그로 재정렬된 전체 목록을 받아 위치대로 orderIndex를 다시 부여하고 저장한다.
  Future<void> reorder(List<CardItem> reordered) async {
    final repo = ref.read(cardRepositoryProvider);
    for (var i = 0; i < reordered.length; i++) {
      if (reordered[i].orderIndex != i) {
        reordered[i].orderIndex = i;
        await repo.add(reordered[i]);
      }
    }
    state = repo.getAll();
  }
}

final cardProvider =
    NotifierProvider<CardNotifier, List<CardItem>>(CardNotifier.new);

/// 등록된 체크카드 목록(표시 순서대로).
final checkCardsProvider = Provider<List<CardItem>>((ref) =>
    ref.watch(cardProvider).where((c) => c.type == CardType.check).toList());

/// 등록된 신용카드 목록(법인/업무용 카드 포함 — 실질적으로 신용 결제 라인이므로).
final creditCardsProvider = Provider<List<CardItem>>((ref) => ref
    .watch(cardProvider)
    .where((c) => c.type == CardType.credit || c.type == CardType.corporate)
    .toList());
