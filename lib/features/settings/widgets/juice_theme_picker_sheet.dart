import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../data/models/juice_theme.dart';

/// '목표 금액' 등 다른 설정 타일과 같은 스타일로 여는 주스 테마 선택 바텀시트.
/// 체크 아이콘 대신 선택된 타일 전체가 해당 과일의 시그니처 색으로 물든다.
Future<JuiceThemeType?> showJuiceThemePickerSheet(
    BuildContext context, JuiceThemeType current) {
  return showModalBottomSheet<JuiceThemeType>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _JuiceThemePickerSheet(current: current),
  );
}

/// 랜덤 테마 미리보기 바 및 선택 시 강조에 쓰는 무지개 그라데이션/액센트.
const _randomPreviewGradient = LinearGradient(
  colors: [
    Color(0xFFFF3B30), // 레드
    Color(0xFFFF9500), // 오렌지
    Color(0xFFFFCC00), // 옐로우
    Color(0xFF34C759), // 그린
    Color(0xFF007AFF), // 블루
    Color(0xFF5856D6), // 퍼플
  ],
);
const _randomAccentColor = Color(0xFFCC33CC); // 보라~핑크빛 단색 액센트

class _JuiceThemePickerSheet extends StatelessWidget {
  const _JuiceThemePickerSheet({required this.current});

  final JuiceThemeType current;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child:
                  Text('주스 테마', style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: juiceThemes
                      .map((theme) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _JuiceThemeCard(
                              theme: theme,
                              selected: theme.type == current,
                              onTap: () {
                                HapticFeedback.selectionClick();
                                Navigator.of(context).pop(theme.type);
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 테마 선택 바텀시트의 카드 한 장. 선택 시 해당 테마의 highColor로 보더/틴트가 물든다.
class _JuiceThemeCard extends StatelessWidget {
  const _JuiceThemeCard(
      {required this.theme, required this.selected, required this.onTap});

  final JuiceTheme theme;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isRandom = theme.type == JuiceThemeType.random;
    final accent = isRandom ? _randomAccentColor : theme.highColor;

    return Material(
      color: selected ? accent.withValues(alpha: 0.1) : Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: selected ? accent : Colors.white10,
                width: selected ? 2 : 1),
          ),
          child: Row(
            children: [
              Text(theme.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(theme.name,
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: SizedBox(
                        height: 6,
                        width: double.infinity,
                        child: isRandom
                            ? const DecoratedBox(
                                decoration: BoxDecoration(
                                    gradient: _randomPreviewGradient))
                            : Row(
                                children: [
                                  Expanded(
                                      child: Container(color: theme.highColor)),
                                  Expanded(
                                      child:
                                          Container(color: theme.mediumColor)),
                                  Expanded(
                                      child: Container(color: theme.lowColor)),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
