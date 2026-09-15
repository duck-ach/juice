import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/juice_theme_provider.dart';

/// 체크마크(✓) 없이 배경 틴트 + 테두리 + 볼드 텍스트만으로 선택 상태를 표현하는 칩.
/// 표준 `ChoiceChip`은 선택 시 체크 아이콘이 나타나 텍스트 위치가 밀리는 레이아웃
/// 흔들림이 있어, 온보딩/저축 플래너 등 빠른 선택 칩 전반에서 이 위젯으로 대체한다.
class JuiceChoiceChip extends ConsumerWidget {
  const JuiceChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(resolvedJuiceThemeProvider).highColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFF7A00).withValues(alpha: 0.2)
              : (isDark ? const Color(0xFF241E1A) : const Color(0xFFEFE8E1)),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? themeColor : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
            color: selected
                ? themeColor
                : (isDark ? Colors.white60 : const Color(0xFF7A6E65)),
          ),
        ),
      ),
    );
  }
}
