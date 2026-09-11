import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';
import '../data/models/juice_theme.dart';

const _juiceThemeTypeKey = 'juiceThemeType';

/// 사용자가 설정에서 고른 주스 테마 선택값(랜덤 포함). 기본값은 오렌지.
class JuiceThemeTypeNotifier extends Notifier<JuiceThemeType> {
  @override
  JuiceThemeType build() {
    final stored =
        Hive.box(HiveBoxes.settings).get(_juiceThemeTypeKey) as String?;
    return JuiceThemeType.values.firstWhere(
      (t) => t.name == stored,
      orElse: () => JuiceThemeType.orange,
    );
  }

  Future<void> setType(JuiceThemeType type) async {
    await Hive.box(HiveBoxes.settings).put(_juiceThemeTypeKey, type.name);
    state = type;
  }
}

final juiceThemeTypeProvider =
    NotifierProvider<JuiceThemeTypeNotifier, JuiceThemeType>(
  JuiceThemeTypeNotifier.new,
);

/// 실제 홈 화면에 적용되는 테마. '랜덤' 선택 시 앱 실행(프로바이더 생성)마다 한 번 새로 뽑는다.
final resolvedJuiceThemeProvider = Provider<JuiceTheme>((ref) {
  final type = ref.watch(juiceThemeTypeProvider);
  if (type == JuiceThemeType.random) {
    final pool =
        juiceThemes.where((t) => t.type != JuiceThemeType.random).toList();
    return pool[Random().nextInt(pool.length)];
  }
  return juiceThemes.firstWhere((t) => t.type == type,
      orElse: () => juiceThemes.first);
});
