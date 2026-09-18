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
    this.originalAmount,
    this.originalCurrency,
    this.exchangeRate,
    this.isSavings = false,
    this.isCorporate = false,
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

  /// 외화로 입력한 원본 결제 금액(예: 15.50). 기준 통화로 입력했으면 null.
  @HiveField(13)
  double? originalAmount;

  /// 원본 결제 통화 코드(예: 'USD'). 기준 통화로 입력했으면 null.
  @HiveField(14)
  String? originalCurrency;

  /// 저장 시점에 적용한 결제일 기준 환율(1 [originalCurrency] = ? 기준 통화). [amount]는
  /// 이미 이 환율로 환산되어 기준 통화로 저장된 값이므로, 예산/합계 계산은 항상 [amount]만 쓰면 된다.
  @HiveField(15)
  double? exchangeRate;

  /// true면 지출/수입이 아닌 저축·투자(통장 이동/자산 적립) 기록. 캘린더·통계·자산
  /// 화면에는 정상 표시되지만, 홈 화면 주스 게이지(생활비 예산) 소진량 계산에서는
  /// 고정지출처럼 항상 제외된다. [isIncome]과 동시에 true가 되지 않는다.
  @HiveField(16, defaultValue: false)
  bool isSavings;

  /// true면 법인/업무용 카드 결제 — 카테고리 선택 없이 등록되고, 캘린더 합계·주스 게이지·
  /// 통계(카테고리별/결제수단별 도넛)에서 항상 제외되어 개인 지출과 완전히 분리된다.
  /// 하단 상세 내역 리스트에는 표시되지만 별도 회색 뱃지로 구분한다.
  @HiveField(17, defaultValue: false)
  bool isCorporate;

  /// 외화로 입력된 지출인지.
  bool get isForeignCurrency => originalCurrency != null;

  PaymentMethod get paymentMethod => PaymentMethod.values.firstWhere(
        (e) => e.name == paymentMethodName,
        orElse: () => PaymentMethod.checkCard,
      );

  set paymentMethod(PaymentMethod value) => paymentMethodName = value.name;

  /// 할부(2개월 이상 분할)로 등록된 거래인지.
  bool get isInstallment =>
      paymentMethod == PaymentMethod.creditCard && installmentMonths > 1;
}
