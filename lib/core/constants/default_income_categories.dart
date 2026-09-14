import 'package:flutter/material.dart';

import '../../data/models/category.dart';

/// 앱 최초 실행/업데이트 시 로컬 DB에 시딩되는 기본 제공 수입 카테고리.
/// id는 과거 고정 수입 카테고리 목록 중 개념이 겹치는 4개를 그대로 이어받아,
/// 이미 기록된 수입 내역(categoryId)과의 참조 호환을 최대한 유지한다.
class DefaultIncomeCategories {
  DefaultIncomeCategories._();

  static final List<Category> seed = [
    Category(
      id: 'income_salary',
      name: '월급',
      iconCodePoint: Icons.account_balance_wallet.codePoint,
      colorValue: 0xFF2196F3,
      isDefault: true,
      orderIndex: 0,
      description: '달콤한 피와 땀의 결실 💼',
      type: CategoryType.income,
    ),
    Category(
      id: 'income_side',
      name: '부수입/알바',
      iconCodePoint: Icons.work_outline.codePoint,
      colorValue: 0xFF00BFA5,
      isDefault: true,
      orderIndex: 1,
      description: '쏠쏠하게 차오르는 보너스 꿀 🍯',
      type: CategoryType.income,
    ),
    Category(
      id: 'income_allowance',
      name: '용돈',
      iconCodePoint: Icons.card_giftcard.codePoint,
      colorValue: 0xFFFFB300,
      isDefault: true,
      orderIndex: 2,
      description: '기분 좋은 서프라이즈 선물 🎁',
      type: CategoryType.income,
    ),
    Category(
      id: 'income_finance',
      name: '금융소득(이자/배당)',
      iconCodePoint: Icons.trending_up.codePoint,
      colorValue: 0xFF7C4DFF,
      isDefault: true,
      orderIndex: 3,
      description: '돈이 돈을 벌어온 열매 📈',
      type: CategoryType.income,
    ),
    Category(
      id: 'income_etc',
      name: '기타 수입',
      iconCodePoint: Icons.more_horiz.codePoint,
      colorValue: 0xFF9E9E9E,
      isDefault: true,
      orderIndex: 4,
      description: '기타 다채로운 수입 💧',
      type: CategoryType.income,
    ),
  ];
}
