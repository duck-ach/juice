import 'package:flutter/material.dart';

int _channel(double component) => (component * 255).round() & 0xff;

/// Color.value가 deprecated된 이후, Hive에 저장하는 32비트 ARGB int(colorValue)로
/// 직렬화할 때 쓰는 컴포넌트 접근자 기반 변환.
extension ColorArgbX on Color {
  int toArgbInt() =>
      (_channel(a) << 24) | (_channel(r) << 16) | (_channel(g) << 8) | _channel(b);
}
