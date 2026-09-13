import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'notification_copy.dart';

/// 서버 없이 온디바이스 스케줄링만으로 동작하는 감성 리마인더 알림.
///
/// 앱이 한국어 전용이라 기기 타임존 조회 없이 'Asia/Seoul'(DST 없음)을 그대로 사용한다.
/// 정확한 시각 배달을 위한 Android 12+ SCHEDULE_EXACT_ALARM 권한 요청을 피하려고
/// [AndroidScheduleMode.inexactAllowWhileIdle]을 사용한다 — 몇 분 오차는 감성 알림 특성상 허용.
class NotificationService {
  NotificationService._();

  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static const _channelId = 'juice_reminders';
  static const _channelName = '주스 알림';

  /// 롤링 스케줄 윈도우(오늘 포함 며칠 치를 미리 예약해둘지).
  static const _windowDays = 30;

  static Future<void> init() async {
    if (_initialized) return;
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

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

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: '아침/저녁 지출 기록 리마인더 및 응원 메시지',
    ),
    iOS: DarwinNotificationDetails(),
  );

  /// 저녁/아침 롤링 알림과 재방문 유도 알림을 모두 새로 예약한다.
  /// 앱을 켤 때마다 호출되어, "마지막 방문 후 n일" 카운트가 자연스럽게 지금 시점으로 리셋된다.
  static Future<void> rescheduleAll() async {
    await _cancelDailyReminders();
    final today = tz.TZDateTime.now(tz.local);
    for (var i = 0; i < _windowDays; i++) {
      final day = _addDays(today, i);
      await _scheduleEvening(day, i);
      await _scheduleMorning(day, i);
    }
    await _rescheduleComebackReminders(today);
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

  static tz.TZDateTime _addDays(tz.TZDateTime from, int days) =>
      tz.TZDateTime(tz.local, from.year, from.month, from.day).add(Duration(days: days));

  /// 알림 문구가 매일 랜덤처럼 보이되, 같은 날짜에 재스케줄해도 같은 문구가 나오도록
  /// 날짜를 시드로 쓰는 결정적 pseudo-random 인덱스.
  static int _seededIndex(DateTime day, int poolLength, int salt) {
    final seed = day.year * 10000 + day.month * 100 + day.day + salt;
    return seed.hashCode.abs() % poolLength;
  }

  static Future<void> _scheduleEvening(tz.TZDateTime day, int dayOffset) async {
    final scheduled = tz.TZDateTime(tz.local, day.year, day.month, day.day, 20);
    if (scheduled.isBefore(tz.TZDateTime.now(tz.local))) return;
    final (title, body) = NotificationCopyPool.evening[
        _seededIndex(day, NotificationCopyPool.evening.length, 1)];
    await _plugin.zonedSchedule(
      _eveningId(dayOffset),
      title,
      body,
      scheduled,
      _details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  static Future<void> _scheduleMorning(tz.TZDateTime day, int dayOffset) async {
    final scheduled = tz.TZDateTime(tz.local, day.year, day.month, day.day, 7);
    if (scheduled.isBefore(tz.TZDateTime.now(tz.local))) return;

    final (title, body) = switch (day.weekday) {
      DateTime.monday => NotificationCopyPool.mondayMorning,
      DateTime.sunday => NotificationCopyPool.sundayMorning[
          _seededIndex(day, NotificationCopyPool.sundayMorning.length, 2)],
      _ => NotificationCopyPool.weekdayMorning[
          _seededIndex(day, NotificationCopyPool.weekdayMorning.length, 3)],
    };
    await _plugin.zonedSchedule(
      _morningId(dayOffset),
      title,
      body,
      scheduled,
      _details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  /// 지금 이 순간을 "마지막 방문"으로 보고, n일 후 재방문 유도 알림을 예약한다.
  static Future<void> _rescheduleComebackReminders(tz.TZDateTime now) async {
    final offsets = NotificationCopyPool.comebackOffsetDays;
    for (var i = 0; i < offsets.length; i++) {
      final (title, body) = NotificationCopyPool.comeback[i];
      final scheduled = _addDays(
          tz.TZDateTime(tz.local, now.year, now.month, now.day, 20), offsets[i]);
      await _plugin.zonedSchedule(
        _comebackId(i),
        title,
        body,
        scheduled,
        _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }
}
