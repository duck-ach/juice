import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/notification_settings_provider.dart';

/// 알림 설정 서브 화면 — 아침/저녁 리마인더 및 응원 메시지 켜기/끄기.
class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(notificationSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('알림 설정')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text('알림 설정', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '매일 아침 7시, 저녁 8시에 기록을 유도하는 알림을 보내드려요.',
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
              title: const Text('주스 알림 받기'),
              subtitle: const Text('오래 접속하지 않으면 재방문을 유도하는 알림도 함께 보내요.'),
            ),
          ),
        ],
      ),
    );
  }
}
