import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 1)
class Expense extends HiveObject {
  Expense({
    required this.id,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.memo,
    this.isFixed = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @HiveField(0)
  String id;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String categoryId;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String? memo;

  /// 고정지출(월세, 보험료 등)로 표시되면 주간 주스 게이지 소진량 계산에서 제외됨.
  @HiveField(5)
  bool isFixed;

  @HiveField(6)
  DateTime createdAt;
}
