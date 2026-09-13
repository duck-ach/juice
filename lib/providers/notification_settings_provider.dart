import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/notifications/notification_service.dart';
import '../data/local/prefs_service.dart';

const notificationsEnabledKey = 'notificationsEnabled';

/// 알림 켜기/끄기 토글. 기본값은 켜짐.
class NotificationSettingsNotifier extends Notifier<bool> {
  @override
  bool build() => PrefsService.prefs.getBool(notificationsEnabledKey) ?? true;

  Future<void> setEnabled(bool value) async {
    await PrefsService.prefs.setBool(notificationsEnabledKey, value);
    state = value;
    if (value) {
      final granted = await NotificationService.requestPermissions();
      if (granted) await NotificationService.rescheduleAll();
    } else {
      await NotificationService.cancelAll();
    }
  }
}

final notificationSettingsProvider =
    NotifierProvider<NotificationSettingsNotifier, bool>(
        NotificationSettingsNotifier.new);
