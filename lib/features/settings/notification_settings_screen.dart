import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/notification_settings_provider.dart';

/// 알림 설정 서브 화면 — 아침/저녁 리마인더 및 응원 메시지 켜기/끄기.
class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final enabled = ref.watch(notificationSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(loc.notificationSettingsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text(loc.notificationSettingsTitle,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            loc.notificationScheduleDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: SwitchListTile(
              value: enabled,
              onChanged: (value) => ref
                  .read(notificationSettingsProvider.notifier)
                  .setEnabled(value),
              title: Text(loc.receiveNotificationsTitle),
              subtitle: Text(loc.receiveNotificationsDescription),
            ),
          ),
        ],
      ),
    );
  }
}
