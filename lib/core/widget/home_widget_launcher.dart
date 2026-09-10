import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';

import '../../features/dashboard/widgets/add_expense_sheet.dart';
import '../navigation/root_navigator.dart';
import 'home_widget_keys.dart';

/// [빠른 입력 위젯] 탭으로 앱이 열렸을 때(콜드/웜 스타트) 딥링크를 감지해
/// 지출 입력 바텀시트를 자동으로 띄운다.
class HomeWidgetLauncher extends StatefulWidget {
  const HomeWidgetLauncher({super.key, required this.child});

  final Widget child;

  @override
  State<HomeWidgetLauncher> createState() => _HomeWidgetLauncherState();
}

class _HomeWidgetLauncherState extends State<HomeWidgetLauncher> {
  StreamSubscription<Uri?>? _subscription;

  @override
  void initState() {
    super.initState();
    _handleInitialLaunch();
    _subscription = HomeWidget.widgetClicked.listen(_handleUri);
  }

  Future<void> _handleInitialLaunch() async {
    final uri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    _handleUri(uri);
  }

  void _handleUri(Uri? uri) {
    if (uri == null || uri.host != HomeWidgetDeepLinks.addExpenseHost) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = rootNavigatorKey.currentContext;
      if (context != null) showAddExpenseSheet(context);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
