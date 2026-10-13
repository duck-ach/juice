import 'package:hive/hive.dart';

import '../../core/notifications/notification_service.dart';
import '../../providers/app_lock_provider.dart';
import '../models/card_item.dart';
import '../models/category.dart';
import '../models/expense.dart';
import '../models/juice_saving_history.dart';
import '../models/weekly_budget.dart';
import 'hive_service.dart';
import 'prefs_service.dart';

/// 로컬 데이터 전체(Hive 박스·SharedPreferences·앱 잠금 PIN·예약 알림)를 지우고
/// 기본 카테고리/카드만 다시 채운다. 호출 후에는 앱 상태를 새로 읽도록 재시작해야 한다.
class ResetService {
  ResetService._();

  static Future<void> resetAll() async {
    await NotificationService.cancelAll();
    // Hive는 열린 박스의 타입 인자가 다르면 예외를 던지므로 박스마다 타입을 맞춰 연다.
    await Hive.box<Category>(HiveBoxes.categories).clear();
    await Hive.box<Expense>(HiveBoxes.expenses).clear();
    await Hive.box<WeeklyBudget>(HiveBoxes.weeklyBudgets).clear();
    await Hive.box(HiveBoxes.settings).clear();
    await Hive.box<CardItem>(HiveBoxes.cards).clear();
    await Hive.box<JuiceSavingHistory>(HiveBoxes.juiceSavingHistory).clear();
    await PrefsService.prefs.clear();
    await clearStoredPin();
    await HiveService.seedDefaults();
  }
}
