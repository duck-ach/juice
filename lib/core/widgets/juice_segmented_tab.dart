import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/juice_theme_provider.dart';

/// 앱 전역에서 쓰는 슬라이딩 캡슐(pill) 형태의 세그먼티드 탭. `SegmentedButton`/`ChoiceChip`을
/// 대체해, 선택 표시에 체크 아이콘(✓)을 쓰지 않고 배경 캡슐이 선택된 탭 위치로 부드럽게
/// 이동하는 방식으로 표현한다. 라벨은 항상 한 줄로 고정(overflow는 말줄임표)해 긴 텍스트로
/// 인한 줄바꿈/레이아웃 깨짐을 막는다. 선택된 탭의 하이라이트/텍스트 색상은 현재 선택된
/// 주스 테마([resolvedJuiceThemeProvider])를 따른다(고정 오렌지색이 아님).
class JuiceSegmentedTab extends ConsumerWidget {
  const JuiceSegmentedTab({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeColor = ref.watch(resolvedJuiceThemeProvider).highColor;
    final trackColor =
        isDark ? const Color(0xFF241E1A) : const Color(0xFFEFE8E1);
    final selectedPillColor = themeColor.withValues(alpha: isDark ? 0.28 : 0.2);
    final selectedTextColor = themeColor;
    final unselectedTextColor =
        isDark ? Colors.white60 : const Color(0xFF7A6E65);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / items.length;
          return Stack(
            children: [
              if (selectedIndex >= 0 && selectedIndex < items.length)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  left: segmentWidth * selectedIndex,
                  top: 0,
                  bottom: 0,
                  width: segmentWidth,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: selectedPillColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              Row(
                children: [
                  for (var i = 0; i < items.length; i++)
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => onTabChanged(i),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Text(
                            items[i],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: i == selectedIndex
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: i == selectedIndex
                                  ? selectedTextColor
                                  : unselectedTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
