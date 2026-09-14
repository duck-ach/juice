import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants/default_categories.dart';
import '../../core/constants/default_cards.dart';
import '../../core/constants/default_income_categories.dart';
import '../models/card_item.dart';
import '../models/category.dart';
import '../models/expense.dart';
import '../models/juice_saving_history.dart';
import '../models/weekly_budget.dart';

class HiveBoxes {
  HiveBoxes._();

  static const categories = 'categories';
  static const expenses = 'expenses';
  static const weeklyBudgets = 'weeklyBudgets';
  static const settings = 'settings';
  static const cards = 'cards';
  static const juiceSavingHistory = 'juiceSavingHistory';
}

/// 로컬 DB(Hive) 초기화 및 박스 오픈을 담당. 서버 없이 앱 내 영구 저장을 처리한다.
class HiveService {
  HiveService._();

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(CategoryAdapter());
    Hive.registerAdapter(ExpenseAdapter());
    Hive.registerAdapter(WeeklyBudgetAdapter());
    Hive.registerAdapter(CardItemAdapter());
    Hive.registerAdapter(JuiceSavingHistoryAdapter());

    await Future.wait([
      Hive.openBox<Category>(HiveBoxes.categories),
      Hive.openBox<Expense>(HiveBoxes.expenses),
      Hive.openBox<WeeklyBudget>(HiveBoxes.weeklyBudgets),
      Hive.openBox(HiveBoxes.settings),
      Hive.openBox<CardItem>(HiveBoxes.cards),
      Hive.openBox<JuiceSavingHistory>(HiveBoxes.juiceSavingHistory),
    ]);

    await _seedDefaultCategoriesIfNeeded();
    await _seedDefaultIncomeCategoriesIfNeeded();
    await _seedDefaultCardsIfNeeded();
  }

  static Future<void> _seedDefaultCategoriesIfNeeded() async {
    final box = Hive.box<Category>(HiveBoxes.categories);
    if (box.isEmpty) {
      for (final category in DefaultCategories.seed) {
        await box.put(category.id, category);
      }
    }
  }

  /// 기존 설치본에도 수입 카테고리가 없다면 한 번만 시딩한다(카테고리 박스가 비어있지
  /// 않아도, 즉 지출 카테고리는 이미 있어도 수입 카테고리만 없을 수 있음).
  static Future<void> _seedDefaultIncomeCategoriesIfNeeded() async {
    final box = Hive.box<Category>(HiveBoxes.categories);
    final hasIncomeCategory =
        box.values.any((c) => c.type == CategoryType.income);
    if (!hasIncomeCategory) {
      for (final category in DefaultIncomeCategories.seed) {
        await box.put(category.id, category);
      }
    }
  }

  static Future<void> _seedDefaultCardsIfNeeded() async {
    final box = Hive.box<CardItem>(HiveBoxes.cards);
    if (box.isEmpty) {
      for (final card in DefaultCards.seed) {
        await box.put(card.id, card);
      }
    }
  }
}
