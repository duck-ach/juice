import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../../data/local/prefs_service.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';
import '../../providers/notification_settings_provider.dart';
import 'notification_copy.dart';

/// 서버 없이 온디바이스 스케줄링만으로 동작하는 감성 리마인더 알림.
///
/// 알림 시각(아침 7시/저녁 8시)은 항상 "기기의 현재 타임존" 기준 현지 시각이다. 예약할
/// 때마다([rescheduleAll]) 기기 타임존을 다시 읽어 [tz.local]을 맞추므로, 해외로 이동하거나
/// 서머타임이 바뀌어도 앱을 열 때 새 현지 시각으로 재예약된다. 문구는 앱 언어(설정에서 고른 언어)로
/// 만들어지며, 언어를 바꾸면 곧바로 다시 예약된다.
/// 정확한 시각 배달을 위한 Android 12+ SCHEDULE_EXACT_ALARM 권한 요청을 피하려고
/// [AndroidScheduleMode.inexactAllowWhileIdle]을 사용한다 — 몇 분 오차는 감성 알림 특성상 허용.
class NotificationService {
  NotificationService._();

  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static const _channelId = 'juice_reminders';

  /// 롤링 스케줄 윈도우(오늘 포함 며칠 치를 미리 예약해둘지).
  static const _windowDays = 30;

  static Future<void> init() async {
    if (_initialized) return;
    tz_data.initializeTimeZones();
    await _syncLocalTimezone();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
    );
    _initialized = true;
  }

  /// 기기의 현재 IANA 타임존(예: 'Asia/Tokyo')을 읽어 [tz.local]로 설정한다. 네이티브 조회가
  /// 실패하면, 기기의 현재 UTC 오프셋과 같은 타임존을 DB에서 찾아 대신 쓴다(그것도 없으면 UTC).
  static Future<void> _syncLocalTimezone() async {
    try {
      final name = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(name));
      return;
    } catch (e) {
      debugPrint('timezone lookup failed, falling back to offset match: $e');
    }
    final now = DateTime.now();
    final offsetMs = now.timeZoneOffset.inMilliseconds;
    for (final location in tz.timeZoneDatabase.locations.values) {
      if (location.timeZone(now.millisecondsSinceEpoch).offset == offsetMs) {
        tz.setLocalLocation(location);
        return;
      }
    }
    tz.setLocalLocation(tz.UTC);
  }

  static AppLocalizations _loc() =>
      lookupAppLocalizations(resolveStoredLocale().locale);

  static Future<bool> requestPermissions() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    final androidGranted = await android?.requestNotificationsPermission();
    final iosGranted =
        await ios?.requestPermissions(alert: true, badge: true, sound: true);
    return (androidGranted ?? true) && (iosGranted ?? true);
  }

  static NotificationDetails _details(AppLocalizations loc) =>
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          loc.notifChannelName,
          channelDescription: loc.notifChannelDescription,
        ),
        iOS: const DarwinNotificationDetails(),
      );

  /// 알림이 켜져 있을 때만 다시 예약한다(언어 변경 등 설정이 바뀐 직후 호출).
  static Future<void> rescheduleIfEnabled() async {
    final enabled =
        PrefsService.prefs.getBool(notificationsEnabledKey) ?? true;
    if (!enabled || !_initialized) return;
    await rescheduleAll();
  }

  /// 저녁/아침 롤링 알림과 재방문 유도 알림을 모두 새로 예약한다.
  /// 앱을 켤 때마다 호출되어, "마지막 방문 후 n일" 카운트가 자연스럽게 지금 시점으로 리셋된다.
  static Future<void> rescheduleAll() async {
    await _syncLocalTimezone();
    final loc = _loc();
    await _cancelDailyReminders();
    final today = tz.TZDateTime.now(tz.local);
    for (var i = 0; i < _windowDays; i++) {
      final day = _addDays(today, i);
      await _scheduleEvening(day, i, loc);
      await _scheduleMorning(day, i, loc);
    }
    await _rescheduleComebackReminders(today, loc);
  }

  static Future<void> cancelAll() => _plugin.cancelAll();

  static Future<void> _cancelDailyReminders() async {
    for (var i = 0; i < _windowDays; i++) {
      await _plugin.cancel(_eveningId(i));
      await _plugin.cancel(_morningId(i));
    }
    for (var i = 0; i < NotificationCopyPool.comebackOffsetDays.length; i++) {
      await _plugin.cancel(_comebackId(i));
    }
  }

  static int _eveningId(int dayOffset) => 2000 + dayOffset;
  static int _morningId(int dayOffset) => 3000 + dayOffset;
  static int _comebackId(int index) => 4000 + index;

  /// [from]의 날짜에서 [days]일 뒤 자정. 24시간(Duration)을 더하면 서머타임 전환일에 시각/날짜가
  /// 어긋나므로, 달력 기준으로 일(day)을 더한다(TZDateTime 생성자가 월/연 넘김을 정규화한다).
  static tz.TZDateTime _addDays(tz.TZDateTime from, int days) =>
      tz.TZDateTime(tz.local, from.year, from.month, from.day + days);

  /// 알림 문구가 매일 랜덤처럼 보이되, 같은 날짜에 재스케줄해도 같은 문구가 나오도록
  /// 날짜를 시드로 쓰는 결정적 pseudo-random 인덱스.
  static int _seededIndex(DateTime day, int poolLength, int salt) {
    final seed = day.year * 10000 + day.month * 100 + day.day + salt;
    return seed.hashCode.abs() % poolLength;
  }

  static Future<void> _scheduleEvening(
      tz.TZDateTime day, int dayOffset, AppLocalizations loc) async {
    final scheduled = tz.TZDateTime(tz.local, day.year, day.month, day.day, 20);
    if (scheduled.isBefore(tz.TZDateTime.now(tz.local))) return;
    final pool = NotificationCopyPool.evening(loc);
    final (title, body) = pool[_seededIndex(day, pool.length, 1)];
    await _plugin.zonedSchedule(
      _eveningId(dayOffset),
      title,
      body,
      scheduled,
      _details(loc),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  static Future<void> _scheduleMorning(
      tz.TZDateTime day, int dayOffset, AppLocalizations loc) async {
    final scheduled = tz.TZDateTime(tz.local, day.year, day.month, day.day, 7);
    if (scheduled.isBefore(tz.TZDateTime.now(tz.local))) return;

    final sunday = NotificationCopyPool.sundayMorning(loc);
    final weekday = NotificationCopyPool.weekdayMorning(loc);
    final (title, body) = switch (day.weekday) {
      DateTime.monday => NotificationCopyPool.mondayMorning(loc),
      DateTime.sunday => sunday[_seededIndex(day, sunday.length, 2)],
      _ => weekday[_seededIndex(day, weekday.length, 3)],
    };
    await _plugin.zonedSchedule(
      _morningId(dayOffset),
      title,
      body,
      scheduled,
      _details(loc),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  /// 지금 이 순간을 "마지막 방문"으로 보고, n일 후 재방문 유도 알림을 예약한다.
  static Future<void> _rescheduleComebackReminders(
      tz.TZDateTime now, AppLocalizations loc) async {
    final offsets = NotificationCopyPool.comebackOffsetDays;
    final copies = NotificationCopyPool.comeback(loc);
    for (var i = 0; i < offsets.length; i++) {
      final (title, body) = copies[i];
      final scheduled = tz.TZDateTime(
          tz.local, now.year, now.month, now.day + offsets[i], 20);
      await _plugin.zonedSchedule(
        _comebackId(i),
        title,
        body,
        scheduled,
        _details(loc),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }
}
