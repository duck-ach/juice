import 'package:flutter/material.dart';

import '../../core/responsive/responsive.dart';
import '../../l10n/app_localizations.dart';
import '../assets/assets_screen.dart';
import '../calendar/calendar_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../settings/settings_screen.dart';
import '../stats/stats_screen.dart';

/// 홈(대시보드)/캘린더/자산/지출통계/설정 탭을 오가는 최상위 셸.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  /// 넓은 화면에서 목록형 탭 본문의 최대 너비. 홈(대시보드)은 자체 2단 레이아웃을 쓴다.
  static const _tabMaxWidth = 760.0;

  static const _tabs = <Widget>[
    DashboardScreen(),
    ConstrainedContent(maxWidth: _tabMaxWidth, child: CalendarScreen()),
    ConstrainedContent(maxWidth: _tabMaxWidth, child: AssetsScreen()),
    ConstrainedContent(maxWidth: _tabMaxWidth, child: StatsScreen()),
    ConstrainedContent(maxWidth: _tabMaxWidth, child: SettingsScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final info = context.responsive;
    final items = [
      (Icons.local_drink_outlined, Icons.local_drink, loc.navHome),
      (Icons.calendar_month_outlined, Icons.calendar_month, loc.navCalendar),
      (
        Icons.account_balance_wallet_outlined,
        Icons.account_balance_wallet,
        loc.navAssets
      ),
      (Icons.pie_chart_outline, Icons.pie_chart, loc.navStats),
      (Icons.settings_outlined, Icons.settings, loc.navSettings),
    ];
    final body = IndexedStack(index: _index, children: _tabs);

    // medium 이상(태블릿/펼친 폴더블)은 좌측 내비게이션 레일, 그 외에는 하단 탭바.
    if (info.useNavigationRail) {
      final expanded = info.sizeClass == WindowSizeClass.expanded;
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              right: false,
              child: NavigationRail(
                selectedIndex: _index,
                onDestinationSelected: (i) => setState(() => _index = i),
                extended: expanded,
                labelType: expanded
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.all,
                destinations: [
                  for (final (icon, selectedIcon, label) in items)
                    NavigationRailDestination(
                      icon: Icon(icon),
                      selectedIcon: Icon(selectedIcon),
                      label: Text(label),
                    ),
                ],
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: body),
          ],
        ),
      );
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: [
          for (final (icon, selectedIcon, label) in items)
            NavigationDestination(
              icon: Icon(icon),
              selectedIcon: Icon(selectedIcon),
              label: label,
            ),
        ],
      ),
    );
  }
}
