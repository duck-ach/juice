import 'package:flutter/material.dart';

/// 스플래시 화면에 매번 랜덤하게 등장하는 '주스 플레이버' 테마.
class SplashFlavor {
  const SplashFlavor({
    required this.fruitEmoji,
    required this.flavorName,
    required this.primaryColor,
    required this.subText,
  });

  final String fruitEmoji;
  final String flavorName;
  final Color primaryColor;
  final String subText;
}

final splashFlavors = [
  const SplashFlavor(
    fruitEmoji: '🍊',
    flavorName: '오렌지 주스',
    primaryColor: Color(0xFFFF7A00),
    subText: '상쾌하게 채우는 이번 주 예산',
  ),
  const SplashFlavor(
    fruitEmoji: '🍏',
    flavorName: '그린애플 주스',
    primaryColor: Color(0xFF34C759),
    subText: '싱그럽게 아끼는 소비 습관',
  ),
  const SplashFlavor(
    fruitEmoji: '🍇',
    flavorName: '포도 주스',
    primaryColor: Color(0xFF9B51E0),
    subText: '달콤하게 지켜내는 나만의 한도',
  ),
  const SplashFlavor(
    fruitEmoji: '🍓',
    flavorName: '딸기 주스',
    primaryColor: Color(0xFFFF3366),
    subText: '기분 좋게 채워지는 하루',
  ),
];
