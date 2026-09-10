import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/navigation/root_navigator.dart';
import 'core/theme/app_theme.dart';
import 'core/widget/home_widget_service.dart';
import 'data/local/hive_service.dart';
import 'features/splash/splash_screen.dart';
import 'providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await initializeDateFormatting('ko_KR');
  await HomeWidgetService.configure();
  runApp(const ProviderScope(child: JuiceApp()));
}

class JuiceApp extends ConsumerWidget {
  const JuiceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: '주스',
      debugShowCheckedModeBanner: false,
      navigatorKey: rootNavigatorKey,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: const SplashScreen(),
    );
  }
}
