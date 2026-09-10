import 'package:flutter/material.dart';

import '../../data/models/category.dart';

/// 앱 최초 실행 시 로컬 DB에 시딩되는 기본 제공 카테고리.
/// id는 고정 문자열로 관리하여 지출 데이터와의 참조가 항상 안정적으로 유지되도록 함.
class DefaultCategories {
  DefaultCategories._();

  static final List<Category> seed = [
    Category(
      id: 'food',
      name: '식비',
      iconCodePoint: Icons.restaurant.codePoint,
      colorValue: 0xFFFF7A00,
      isDefault: true,
      orderIndex: 0,
      description: '오늘 마신 맛있는 에너지 🍱',
    ),
    Category(
      id: 'cafe',
      name: '카페/간식',
      iconCodePoint: Icons.local_cafe.codePoint,
      colorValue: 0xFFFFB800,
      isDefault: true,
      orderIndex: 1,
      description: '기분 좋아지는 디저트 한 스푼 ☕️',
    ),
    Category(
      id: 'transport',
      name: '교통',
      iconCodePoint: Icons.directions_bus.codePoint,
      colorValue: 0xFF4A90E2,
      isDefault: true,
      orderIndex: 2,
      description: '목적지까지 부드러운 이동 🚌',
    ),
    Category(
      id: 'shopping',
      name: '쇼핑',
      iconCodePoint: Icons.shopping_bag.codePoint,
      colorValue: 0xFFE85D9E,
      isDefault: true,
      orderIndex: 3,
      description: '나를 채우는 득템의 즐거움 🛍️',
    ),
    Category(
      id: 'culture',
      name: '문화/여가',
      iconCodePoint: Icons.movie.codePoint,
      colorValue: 0xFF9B6BD9,
      isDefault: true,
      orderIndex: 4,
      description: '영혼을 채우는 달콤한 휴식 🎬',
    ),
    Category(
      id: 'life',
      name: '생활',
      iconCodePoint: Icons.home.codePoint,
      colorValue: 0xFF34C759,
      isDefault: true,
      orderIndex: 5,
      description: '쾌적한 일상을 위한 한 모금 🧼',
    ),
    Category(
      id: 'etc',
      name: '기타',
      iconCodePoint: Icons.more_horiz.codePoint,
      colorValue: 0xFF8A7A6C,
      isDefault: true,
      orderIndex: 6,
      description: '어디에나 어울리는 다채로운 소비 💬',
    ),
  ];
}
