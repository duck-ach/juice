import 'package:hive/hive.dart';

import '../../l10n/app_localizations.dart';

part 'card_item.g.dart';

/// 카드 분류. Hive에는 [CardItem.typeName]으로 이름(name) 문자열이 저장된다.
enum CardType { check, credit, corporate }

extension CardTypeLabel on CardType {
  String label(AppLocalizations loc) => switch (this) {
        CardType.check => loc.paymentCheckCard,
        CardType.credit => loc.paymentCreditCard,
        CardType.corporate => loc.cardTypeCorporate,
      };
}

@HiveType(typeId: 3)
class CardItem extends HiveObject {
  CardItem({
    required this.id,
    required this.name,
    CardType type = CardType.check,
    required this.colorValue,
    bool? excludeFromJuice,
    this.isDefault = false,
    this.orderIndex = 0,
  })  : typeName = type.name,
        excludeFromJuice = excludeFromJuice ?? (type == CardType.corporate);

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  /// [CardType.name] 문자열로 저장. 직접 쓰지 말고 [type]을 통해 접근할 것.
  @HiveField(2, defaultValue: 'check')
  String typeName;

  /// Color.value (ARGB)
  @HiveField(3)
  int colorValue;

  /// true면 이 카드의 지출은 주간/월간 주스 예산 소진량 계산에서 제외됨(법인카드 기본값).
  @HiveField(4, defaultValue: false)
  bool excludeFromJuice;

  /// 기본 제공 카드 여부 (사용자가 삭제 불가하도록 구분)
  @HiveField(5)
  bool isDefault;

  /// 표시 순서(오름차순). 카드 관리 화면의 드래그 재정렬로 갱신됨.
  @HiveField(6, defaultValue: 0)
  int orderIndex;

  CardType get type => CardType.values.firstWhere(
        (t) => t.name == typeName,
        orElse: () => CardType.check,
      );

  set type(CardType value) => typeName = value.name;
}

extension CardItemDisplay on CardItem {
  String subtitleLabel(AppLocalizations loc) => switch (type) {
        CardType.check => loc.paymentCheckCard,
        CardType.credit => loc.paymentCreditCard,
        CardType.corporate => loc.cardTypeCorporateExcluded,
      };
}
