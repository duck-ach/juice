import 'package:hive/hive.dart';

part 'weekly_budget.g.dart';

@HiveType(typeId: 2)
class WeeklyBudget extends HiveObject {
  WeeklyBudget({
    required this.id,
    required this.weekStartDate,
    required this.amount,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @HiveField(0)
  String id;

  /// 해당 주의 시작일(월요일 00:00 기준으로 정규화하여 저장).
  @HiveField(1)
  DateTime weekStartDate;

  @HiveField(2)
  double amount;

  @HiveField(3)
  DateTime createdAt;
}
