import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/juice_segmented_tab.dart';
import '../../data/models/juice_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/juice_theme_provider.dart';
import '../../providers/theme_provider.dart';
import 'widgets/juice_theme_picker_sheet.dart';

/// 시스템/라이트/다크 모드와 주스 테마(앱 전역 포인트 컬러)를 고르는 서브 화면.
class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final juiceThemeType = ref.watch(juiceThemeTypeProvider);
    final selectedJuiceTheme = juiceThemes.firstWhere(
      (t) => t.type == juiceThemeType,
      orElse: () => juiceThemes.first,
    );

    return Scaffold(
      appBar: AppBar(title: Text(loc.themeSettingsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text(loc.screenModeLabel, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          JuiceSegmentedTab(
            items: [loc.themeModeSystem, loc.themeModeLight, loc.themeModeDark],
            selectedIndex: ThemeMode.values.indexOf(themeMode),
            onTabChanged: (index) => ref
                .read(themeModeProvider.notifier)
                .setThemeMode(ThemeMode.values[index]),
          ),
          const SizedBox(height: 32),
          Text(loc.juiceThemeLabel, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            loc.juiceThemeDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: Text(selectedJuiceTheme.emoji,
                  style: const TextStyle(fontSize: 22)),
              title: Text(loc.juiceThemeLabel),
              subtitle: Text(selectedJuiceTheme.label(loc)),
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
