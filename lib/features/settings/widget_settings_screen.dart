import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/home_widget_settings_provider.dart';

/// 홈 화면 위젯 관련 설정 서브 화면.
class WidgetSettingsScreen extends ConsumerWidget {
  const WidgetSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final hideWidgetAmount = ref.watch(hideWidgetAmountProvider);

    return Scaffold(
      appBar: AppBar(title: Text(loc.widgetSettingsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text(loc.homeScreenWidgetTitle,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            loc.homeScreenWidgetDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: hideWidgetAmount,
            onChanged: (value) =>
                ref.read(hideWidgetAmountProvider.notifier).setHidden(value),
            title: Text(loc.hideWidgetAmountTitle),
            subtitle: Text(loc.hideWidgetAmountDescription),
          ),
        ],
      ),
    );
  }
}
