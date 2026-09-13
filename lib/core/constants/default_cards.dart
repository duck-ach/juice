import '../../data/models/card_item.dart';

/// 앱 최초 실행 시 로컬 DB에 시딩되는 기본 제공 카드.
/// id는 고정 문자열로 관리하여 지출 데이터와의 참조가 항상 안정적으로 유지되도록 함.
class DefaultCards {
  DefaultCards._();

  static final List<CardItem> seed = [
    CardItem(
      id: 'default_check',
      name: '체크카드 (기본)',
      type: CardType.check,
      colorValue: 0xFF00A8FF,
      isDefault: true,
      orderIndex: 0,
    ),
    CardItem(
      id: 'default_credit',
      name: '신용카드 (기본)',
      type: CardType.credit,
      colorValue: 0xFFFF7A00,
      isDefault: true,
      orderIndex: 1,
    ),
  ];
}
