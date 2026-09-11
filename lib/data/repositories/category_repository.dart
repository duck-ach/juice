import 'package:hive/hive.dart';

import '../local/hive_service.dart';
import '../models/category.dart';

class CategoryRepository {
  Box<Category> get _box => Hive.box<Category>(HiveBoxes.categories);

  List<Category> getAll() => _box.values.toList()
    ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

  Future<void> add(Category category) => _box.put(category.id, category);

  Future<void> delete(String id) => _box.delete(id);
}
