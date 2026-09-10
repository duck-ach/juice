import 'package:hive/hive.dart';

import '../local/hive_service.dart';
import '../models/expense.dart';

class ExpenseRepository {
  Box<Expense> get _box => Hive.box<Expense>(HiveBoxes.expenses);

  List<Expense> getAll() => _box.values.toList();

  Future<void> add(Expense expense) => _box.put(expense.id, expense);

  Future<void> delete(String id) => _box.delete(id);
}
