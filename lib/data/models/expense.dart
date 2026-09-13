import 'package:hive/hive.dart';

import 'payment_method.dart';

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
    this.isIncome = false,
    DateTime? createdAt,
    PaymentMethod paymentMethod = PaymentMethod.checkCard,
    this.installmentMonths = 1,
    this.currentInstallmentIndex = 1,
    this.installmentGroupId,
    this.cardId,
  })  : createdAt = createdAt ?? DateTime.now(),
        paymentMethodName = paymentMethod.name;

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

  /// true면 지출이 아닌 수입 기록. 주스 게이지/지출 통계 계산에서는 항상 제외되고
  /// 캘린더·자산 화면에만 반영된다.
  @HiveField(7, defaultValue: false)
  bool isIncome;

  /// [PaymentMethod.name] 문자열로 저장. 직접 쓰지 말고 [paymentMethod]를 통해 접근할 것.
  @HiveField(8, defaultValue: 'checkCard')
  String paymentMethodName;

  /// 할부 개월 수. 일시불/체크카드/현금은 항상 1.
  @HiveField(9, defaultValue: 1)
  int installmentMonths;

  /// 할부 회차(1부터 시작). 일시불은 항상 1.
  @HiveField(10, defaultValue: 1)
  int currentInstallmentIndex;

  /// 같은 할부로 묶여 자동 생성된 거래들을 식별하는 UUID. 일시불/할부 아님이면 null.
  @HiveField(11)
  String? installmentGroupId;

  /// 이 지출에 사용한 [CardItem.id]. 체크/신용카드 결제일 때만 값이 있고, 그 외(현금/더치페이)는 null.
  @HiveField(12)
  String? cardId;

  PaymentMethod get paymentMethod => PaymentMethod.values.firstWhere(
        (e) => e.name == paymentMethodName,
        orElse: () => PaymentMethod.checkCard,
      );

  set paymentMethod(PaymentMethod value) => paymentMethodName = value.name;

  /// 할부(2개월 이상 분할)로 등록된 거래인지.
  bool get isInstallment =>
      paymentMethod == PaymentMethod.creditCard && installmentMonths > 1;
}
