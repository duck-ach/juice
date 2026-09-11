import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/juice_theme.dart';
import '../../providers/juice_theme_provider.dart';
import '../../providers/theme_provider.dart';
import 'widgets/juice_theme_picker_sheet.dart';

/// 시스템/라이트/다크 모드와 주스 테마(앱 전역 포인트 컬러)를 고르는 서브 화면.
class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final juiceThemeType = ref.watch(juiceThemeTypeProvider);
    final selectedJuiceTheme = juiceThemes.firstWhere(
      (t) => t.type == juiceThemeType,
      orElse: () => juiceThemes.first,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('테마 설정')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text('화면 모드', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(value: ThemeMode.system, label: Text('시스템')),
              ButtonSegment(value: ThemeMode.light, label: Text('라이트')),
              ButtonSegment(value: ThemeMode.dark, label: Text('다크')),
            ],
            selected: {themeMode},
            onSelectionChanged: (selection) => ref
                .read(themeModeProvider.notifier)
                .setThemeMode(selection.first),
          ),
          const SizedBox(height: 32),
          Text('주스 테마', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '잔여량에 따라 색이 바뀌는 홈 화면 주스 색을 골라보세요. 앱 전체 포인트 컬러에도 반영돼요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: Text(selectedJuiceTheme.emoji,
                  style: const TextStyle(fontSize: 22)),
              title: const Text('주스 테마'),
              subtitle: Text(selectedJuiceTheme.name),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final selected =
                    await showJuiceThemePickerSheet(context, juiceThemeType);
                if (selected != null) {
                  await ref
                      .read(juiceThemeTypeProvider.notifier)
                      .setType(selected);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
