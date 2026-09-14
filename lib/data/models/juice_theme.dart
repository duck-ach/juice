import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

enum JuiceThemeType {
  orange,
  strawberry,
  apple,
  grape,
  blueberry,
  mulberry,
  random
}

/// 잔여 비율 3단계(충분/주의/임박)에 따라 색이 바뀌는 홈 화면 주스 테마.
class JuiceTheme {
  const JuiceTheme({
    required this.type,
    required this.emoji,
    required this.highColor,
    required this.mediumColor,
    required this.lowColor,
  });

  final JuiceThemeType type;
  final String emoji;
  final Color highColor; // 예산 충분 (가장 많을 때)
  final Color mediumColor; // 예산 주의 (중간)
  final Color lowColor; // 예산 임박/위험 (적을 때)

  String label(AppLocalizations loc) => switch (type) {
        JuiceThemeType.orange => loc.themeOrange,
        JuiceThemeType.strawberry => loc.themeStrawberry,
        JuiceThemeType.apple => loc.themeApple,
        JuiceThemeType.grape => loc.themeGrape,
        JuiceThemeType.blueberry => loc.themeBlueberry,
        JuiceThemeType.mulberry => loc.themeMulberry,
        JuiceThemeType.random => loc.themeRandom,
      };

  /// 잔여 비율(0.0~1.0)에 따라 현재 주스 색상 반환.
  Color getColorByRatio(double remainingRatio) {
    if (remainingRatio > 0.5) return highColor;
    if (remainingRatio > 0.2) return mediumColor;
    return lowColor;
  }
}

final List<JuiceTheme> juiceThemes = [
  const JuiceTheme(
    type: JuiceThemeType.orange,
    emoji: '🍊',
    highColor: Color(0xFFFF7A00),
    mediumColor: Color(0xFFFFA94D),
    lowColor: Color(0xFFFF3B30),
  ),
  const JuiceTheme(
    type: JuiceThemeType.strawberry,
    emoji: '🍓',
    highColor: Color(0xFFFF2D55),
    mediumColor: Color(0xFFFF85A1),
    lowColor: Color(0xFFD63031),
  ),
  const JuiceTheme(
    type: JuiceThemeType.apple,
    emoji: '🍏',
    highColor: Color(0xFF34C759),
    mediumColor: Color(0xFF8CE99A),
    lowColor: Color(0xFFFF922B),
  ),
  const JuiceTheme(
    type: JuiceThemeType.grape,
    emoji: '🍇',
    highColor: Color(0xFF8B2FC9),
    mediumColor: Color(0xFFB368E6),
    lowColor: Color(0xFFE1BEE7),
  ),
  const JuiceTheme(
    type: JuiceThemeType.blueberry,
    emoji: '🫐',
    highColor: Color(0xFF3232FF),
    mediumColor: Color(0xFF8C8CFF),
    lowColor: Color(0xFFC8C8FF),
  ),
  const JuiceTheme(
    type: JuiceThemeType.mulberry,
    emoji: '🫐',
    highColor: Color(0xFF1E272C),
    mediumColor: Color(0xFF4B6584),
    lowColor: Color(0xFF778CA3),
  ),
  const JuiceTheme(
    type: JuiceThemeType.random,
    emoji: '🎲',
    highColor: Color(0xFFFF7A00),
    mediumColor: Color(0xFFFFA94D),
    lowColor: Color(0xFFFF3B30),
  ),
];
