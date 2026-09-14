import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

enum SplashFlavorId { orange, greenApple, grape, strawberry }

/// 스플래시 화면에 매번 랜덤하게 등장하는 '주스 플레이버' 테마.
class SplashFlavor {
  const SplashFlavor({
    required this.id,
    required this.fruitEmoji,
    required this.primaryColor,
  });

  final SplashFlavorId id;
  final String fruitEmoji;
  final Color primaryColor;

  String subText(AppLocalizations loc) => switch (id) {
        SplashFlavorId.orange => loc.splashOrangeSubText,
        SplashFlavorId.greenApple => loc.splashGreenAppleSubText,
        SplashFlavorId.grape => loc.splashGrapeSubText,
        SplashFlavorId.strawberry => loc.splashStrawberrySubText,
      };
}

final splashFlavors = [
  const SplashFlavor(
    id: SplashFlavorId.orange,
    fruitEmoji: '🍊',
    primaryColor: Color(0xFFFF7A00),
  ),
  const SplashFlavor(
    id: SplashFlavorId.greenApple,
    fruitEmoji: '🍏',
    primaryColor: Color(0xFF34C759),
  ),
  const SplashFlavor(
    id: SplashFlavorId.grape,
    fruitEmoji: '🍇',
    primaryColor: Color(0xFF9B51E0),
  ),
  const SplashFlavor(
    id: SplashFlavorId.strawberry,
    fruitEmoji: '🍓',
    primaryColor: Color(0xFFFF3366),
  ),
];
