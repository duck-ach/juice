import 'package:hive/hive.dart';

import '../models/category.dart';
import '../models/expense.dart';
import 'hive_service.dart';

/// 백업 파일에 절대 포함하지 않는 설정 키. 보안 관련 상태는 기기별로 별도 관리한다.
const _excludedSettingsKeys = {'appLockEnabled', 'biometricEnabled'};

/// 로컬 DB 전체(카테고리/지출·수입/예산 설정)를 JSON으로 내보내고 복원하는 서비스.
/// 서버 없이 파일 하나로 기기 간 이전/백업이 가능하도록 한다.
class BackupService {
  BackupService._();

  static const backupVersion = 1;

  static Map<String, dynamic> buildBackupJson() {
    final categories =
        Hive.box<Category>(HiveBoxes.categories).values.map((c) => {
              'id': c.id,
              'name': c.name,
              'iconCodePoint': c.iconCodePoint,
              'colorValue': c.colorValue,
              'isDefault': c.isDefault,
              'orderIndex': c.orderIndex,
              'description': c.description,
              'iconFontFamily': c.iconFontFamily,
            });

    final expenses = Hive.box<Expense>(HiveBoxes.expenses).values.map((e) => {
          'id': e.id,
          'amount': e.amount,
          'categoryId': e.categoryId,
          'date': e.date.toIso8601String(),
          'memo': e.memo,
          'isFixed': e.isFixed,
          'isIncome': e.isIncome,
          'createdAt': e.createdAt.toIso8601String(),
        });

    final settingsBox = Hive.box(HiveBoxes.settings);
    final settings = <String, dynamic>{
      for (final key in settingsBox.keys)
        if (!_excludedSettingsKeys.contains(key))
          key.toString(): settingsBox.get(key),
    };

    return {
      'version': backupVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'categories': categories.toList(),
      'expenses': expenses.toList(),
      'settings': settings,
    };
  }

  /// 백업 JSON의 최소 구조를 검증. 형식이 다르면 예외를 던진다.
  static void _validate(Map<String, dynamic> json) {
    if (json['categories'] is! List || json['expenses'] is! List) {
      throw const FormatException('올바른 주스 백업 파일이 아니에요');
    }
  }

  static Future<void> restoreFromJson(Map<String, dynamic> json) async {
    _validate(json);

    final categoryBox = Hive.box<Category>(HiveBoxes.categories);
    final expenseBox = Hive.box<Expense>(HiveBoxes.expenses);
    final settingsBox = Hive.box(HiveBoxes.settings);

    await categoryBox.clear();
    for (final raw in json['categories'] as List) {
      final m = Map<String, dynamic>.from(raw as Map);
      await categoryBox.put(
        m['id'] as String,
        Category(
          id: m['id'] as String,
          name: m['name'] as String,
          iconCodePoint: m['iconCodePoint'] as int,
          colorValue: m['colorValue'] as int,
          isDefault: m['isDefault'] as bool? ?? false,
          orderIndex: m['orderIndex'] as int? ?? 0,
          description: m['description'] as String? ?? '나만의 특별한 주스 레시피 🍊',
          iconFontFamily: m['iconFontFamily'] as String? ?? 'MaterialIcons',
        ),
      );
    }

    await expenseBox.clear();
    for (final raw in json['expenses'] as List) {
      final m = Map<String, dynamic>.from(raw as Map);
      await expenseBox.put(
        m['id'] as String,
        Expense(
          id: m['id'] as String,
          amount: (m['amount'] as num).toDouble(),
          categoryId: m['categoryId'] as String,
          date: DateTime.parse(m['date'] as String),
          memo: m['memo'] as String?,
          isFixed: m['isFixed'] as bool? ?? false,
          isIncome: m['isIncome'] as bool? ?? false,
          createdAt: m['createdAt'] != null
              ? DateTime.parse(m['createdAt'] as String)
              : null,
        ),
      );
    }

    final settings = json['settings'];
    if (settings is Map) {
      for (final entry in settings.entries) {
        final key = entry.key.toString();
        if (_excludedSettingsKeys.contains(key)) continue;
        await settingsBox.put(key, entry.value);
      }
    }
  }
}
