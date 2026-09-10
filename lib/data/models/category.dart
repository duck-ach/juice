import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 0)
class Category extends HiveObject {
  Category({
    required this.id,
    required this.name,
    required this.iconCodePoint,
    required this.colorValue,
    this.isDefault = false,
    this.orderIndex = 0,
    this.description = '나만의 특별한 주스 레시피 🍊',
    this.iconFontFamily = 'MaterialIcons',
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  /// IconData.codePoint (Material Icons 폰트 기준)
  @HiveField(2)
  int iconCodePoint;

  /// Color.value (ARGB)
  @HiveField(3)
  int colorValue;

  /// 기본 제공 카테고리 여부 (사용자가 삭제 불가하도록 구분)
  @HiveField(4)
  bool isDefault;

  /// 표시 순서(오름차순). 카테고리 관리 화면의 드래그 재정렬로 갱신됨.
  /// defaultValue: 기존 기기에 이미 저장된(필드 추가 이전) 카테고리를 안전하게 읽기 위함.
  @HiveField(5, defaultValue: 0)
  int orderIndex;

  /// 카테고리 한 줄 설명(감성 카피). 사용자가 직접 수정 가능.
  /// defaultValue: 필드 추가 이전 저장된 커스텀 카테고리용 기본 문구.
  @HiveField(6, defaultValue: '나만의 특별한 주스 레시피 🍊')
  String description;

  /// 아이콘 폰트 패밀리.
  @HiveField(7, defaultValue: 'MaterialIcons')
  String? iconFontFamily;
}
