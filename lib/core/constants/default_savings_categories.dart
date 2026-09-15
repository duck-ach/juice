import 'package:flutter/material.dart';

import '../../data/models/category.dart';

/// 앱 최초 실행/업데이트 시 로컬 DB에 시딩되는 기본 제공 저축/투자 카테고리.
class DefaultSavingsCategories {
  DefaultSavingsCategories._();

  static final List<Category> seed = [
    Category(
      id: 'savings_bank',
      name: '저축',
      iconCodePoint: Icons.savings.codePoint,
      colorValue: 0xFFFF6B9A,
      isDefault: true,
      orderIndex: 0,
      description: '차곡차곡 쌓이는 목돈 🏦',
      type: CategoryType.savings,
    ),
    Category(
      id: 'savings_invest',
      name: '투자/주식',
      iconCodePoint: Icons.trending_up.codePoint,
      colorValue: 0xFF3B82F6,
      isDefault: true,
      orderIndex: 1,
      description: '내일을 위해 심는 과일 씨앗 📈',
      type: CategoryType.savings,
    ),
    Category(
      id: 'savings_housing',
      name: '주택청약저축',
      iconCodePoint: Icons.home_work.codePoint,
      colorValue: 0xFF2DD4BF,
      isDefault: true,
      orderIndex: 2,
      description: '달콤한 내 집 마련의 꿈 🏠',
      type: CategoryType.savings,
    ),
    Category(
      id: 'savings_isa',
      name: 'ISA/절세계좌',
      iconCodePoint: Icons.shield_outlined.codePoint,
      colorValue: 0xFF8B5CF6,
      isDefault: true,
      orderIndex: 3,
      description: '든든한 만능 절세 주머니 🛡️',
      type: CategoryType.savings,
    ),
    Category(
      id: 'savings_emergency',
      name: '비상금',
      iconCodePoint: Icons.medical_services_outlined.codePoint,
      colorValue: 0xFFFACC15,
      isDefault: true,
      orderIndex: 4,
      description: '언제든 기댈 수 있는 완충재 🧃',
      type: CategoryType.savings,
    ),
  ];
}
