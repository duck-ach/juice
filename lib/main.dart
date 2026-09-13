import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/navigation/root_navigator.dart';
import 'core/notifications/notification_service.dart';
import 'core/theme/app_theme.dart';
import 'core/widget/home_widget_service.dart';
import 'data/local/hive_service.dart';
import 'data/local/prefs_service.dart';
import 'features/splash/splash_screen.dart';
import 'providers/juice_theme_provider.dart';
import 'providers/notification_settings_provider.dart';
import 'providers/theme_provider.dart';

// ignore: unused_element
late final AppLifecycleListener _notificationLifecycleListener;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await PrefsService.init();
  await initializeDateFormatting('ko_KR');
  await HomeWidgetService.configure();
  await NotificationService.init();
  await _refreshNotificationSchedule();
  // 포그라운드로 돌아올 때도 재방문 유도 알림의 "마지막 방문" 기준 시각을 갱신한다.
  _notificationLifecycleListener =
      AppLifecycleListener(onResume: () {
    unawaited(_refreshNotificationSchedule());
  });
  runApp(const ProviderScope(child: JuiceApp()));
}

/// 알림이 켜져 있으면 권한 확인 후 롤링 스케줄(아침/저녁/재방문 유도)을 새로 예약한다.
Future<void> _refreshNotificationSchedule() async {
  final enabled = PrefsService.prefs.getBool(notificationsEnabledKey) ?? true;
  if (!enabled) return;
  final granted = await NotificationService.requestPermissions();
  if (granted) await NotificationService.rescheduleAll();
}

class JuiceApp extends ConsumerWidget {
  const JuiceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final accent = ref.watch(resolvedJuiceThemeProvider).highColor;

    return MaterialApp(
      title: '주스',
      debugShowCheckedModeBanner: false,
      navigatorKey: rootNavigatorKey,
      theme: AppTheme.light(accent),
      darkTheme: AppTheme.dark(accent),
      themeMode: themeMode,
      home: const SplashScreen(),
    );
  }
}
