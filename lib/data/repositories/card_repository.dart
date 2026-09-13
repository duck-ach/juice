import 'package:hive/hive.dart';

import '../local/hive_service.dart';
import '../models/card_item.dart';

class CardRepository {
  Box<CardItem> get _box => Hive.box<CardItem>(HiveBoxes.cards);

  List<CardItem> getAll() => _box.values.toList()
    ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

  Future<void> add(CardItem card) => _box.put(card.id, card);

  Future<void> delete(String id) => _box.delete(id);
}
