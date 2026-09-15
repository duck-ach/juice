import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../l10n/app_localizations.dart';

part 'category.g.dart';

/// 카테고리 분류. Hive에는 [Category.typeName]으로 이름(name) 문자열이 저장된다.
enum CategoryType { expense, income, savings }

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
    CategoryType type = CategoryType.expense,
  }) : typeName = type.name;

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

  /// [CategoryType.name] 문자열로 저장. 직접 쓰지 말고 [type]을 통해 접근할 것.
  /// defaultValue: 이 필드 추가 이전 저장된 카테고리는 모두 지출 카테고리였음.
  @HiveField(8, defaultValue: 'expense')
  String typeName;

  CategoryType get type => CategoryType.values.firstWhere(
        (t) => t.name == typeName,
        orElse: () => CategoryType.expense,
      );

  set type(CategoryType value) => typeName = value.name;
}

/// 기본 제공 카테고리(id로 식별)의 이름/설명을 현재 언어로 실시간 번역해 보여준다.
/// 사용자가 직접 추가한 커스텀 카테고리는 저장된 값을 그대로 유지한다.
extension CategoryL10nExtension on Category {
  /// 다국어 반영 카테고리 이름
  String getLocalizedName(BuildContext context) {
    if (!isDefault) return name;
    final l10n = AppLocalizations.of(context)!;
    return switch (id) {
      'food' => l10n.category_food_name,
      'cafe' => l10n.category_cafe_name,
      'transport' => l10n.category_transport_name,
      'shopping' => l10n.category_shopping_name,
      'culture' => l10n.category_culture_name,
      'life' => l10n.category_life_name,
      'etc' => l10n.category_etc_name,
      'savings_bank' => l10n.category_savings_bank_name,
      'savings_invest' => l10n.category_savings_invest_name,
      'savings_housing' => l10n.category_savings_housing_name,
      'savings_isa' => l10n.category_savings_isa_name,
      'savings_emergency' => l10n.category_savings_emergency_name,
      'income_salary' => l10n.category_income_salary_name,
      'income_side' => l10n.category_income_side_name,
      'income_allowance' => l10n.category_income_allowance_name,
      'income_finance' => l10n.category_income_finance_name,
      'income_etc' => l10n.category_income_etc_name,
      _ => name,
    };
  }

  /// 다국어 반영 카테고리 설명(서브타이틀)
  String getLocalizedDescription(BuildContext context) {
    if (!isDefault) return description;
    final l10n = AppLocalizations.of(context)!;
    return switch (id) {
      'food' => l10n.category_food_desc,
      'cafe' => l10n.category_cafe_desc,
      'transport' => l10n.category_transport_desc,
      'shopping' => l10n.category_shopping_desc,
      'culture' => l10n.category_culture_desc,
      'life' => l10n.category_life_desc,
      'etc' => l10n.category_etc_desc,
      'savings_bank' => l10n.category_savings_bank_desc,
      'savings_invest' => l10n.category_savings_invest_desc,
      'savings_housing' => l10n.category_savings_housing_desc,
      'savings_isa' => l10n.category_savings_isa_desc,
      'savings_emergency' => l10n.category_savings_emergency_desc,
      'income_salary' => l10n.category_income_salary_desc,
      'income_side' => l10n.category_income_side_desc,
      'income_allowance' => l10n.category_income_allowance_desc,
      'income_finance' => l10n.category_income_finance_desc,
      'income_etc' => l10n.category_income_etc_desc,
      _ => description,
    };
  }
}
