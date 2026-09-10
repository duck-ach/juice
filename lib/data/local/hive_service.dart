import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants/default_categories.dart';
import '../models/category.dart';
import '../models/expense.dart';
import '../models/weekly_budget.dart';

class HiveBoxes {
  HiveBoxes._();

  static const categories = 'categories';
  static const expenses = 'expenses';
  static const weeklyBudgets = 'weeklyBudgets';
  static const settings = 'settings';
}

/// 로컬 DB(Hive) 초기화 및 박스 오픈을 담당. 서버 없이 앱 내 영구 저장을 처리한다.
class HiveService {
  HiveService._();

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(CategoryAdapter());
    Hive.registerAdapter(ExpenseAdapter());
    Hive.registerAdapter(WeeklyBudgetAdapter());

    await Future.wait([
      Hive.openBox<Category>(HiveBoxes.categories),
      Hive.openBox<Expense>(HiveBoxes.expenses),
      Hive.openBox<WeeklyBudget>(HiveBoxes.weeklyBudgets),
      Hive.openBox(HiveBoxes.settings),
    ]);

    await _seedDefaultCategoriesIfNeeded();
  }

  static Future<void> _seedDefaultCategoriesIfNeeded() async {
    final box = Hive.box<Category>(HiveBoxes.categories);
    if (box.isEmpty) {
      for (final category in DefaultCategories.seed) {
        await box.put(category.id, category);
      }
    }
  }
}
