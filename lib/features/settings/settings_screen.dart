import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

import '../../core/utils/week_utils.dart';
import '../../providers/budget_settings_provider.dart';
import '../../providers/expense_provider.dart';
import 'backup_settings_screen.dart';
import 'goal_settings_screen.dart';
import 'security_settings_screen.dart';
import 'theme_settings_screen.dart';
import 'widget_settings_screen.dart';
import 'widgets/savings_card.dart';

/// 설정 메인 화면. 절약 카드 미리보기/공유와, 카테고리별 설정 서브 화면 진입 메뉴만 보여준다.
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _cardKey = GlobalKey();
  bool _sharingCard = false;

  Future<void> _shareCard() async {
    setState(() => _sharingCard = true);
    try {
      final boundary =
          _cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();
      final dir = await getTemporaryDirectory();
      final file = File(
          '${dir.path}/juice_card_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);
      await Share.shareXFiles([XFile(file.path)], text: '이번 주 주스 결산 🍊');
    } finally {
      if (mounted) setState(() => _sharingCard = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final weekStartDay = ref.watch(weekStartDayProvider);
    final targetAmount = ref.watch(targetAmountProvider);
    final spent = ref.watch(weeklySpentProvider);
    final range = currentWeekRange(null, weekStartDay);
    final weekLabel =
        '${DateFormat('M.d').format(range.start)} - ${DateFormat('M.d').format(range.end)}';

    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text('이번 주 절약 카드', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '예산 방어에 성공한 한 주를 카드로 만들어 공유해보세요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          if (targetAmount != null) ...[
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: RepaintBoundary(
                key: _cardKey,
                child: SavingsCard(
                    budget: targetAmount, spent: spent, weekLabel: weekLabel),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _sharingCard ? null : _shareCard,
                icon: const Icon(Icons.ios_share),
                label: Text(_sharingCard ? '카드 생성 중...' : '카드 공유하기'),
              ),
            ),
          ] else
            Text('목표 금액을 먼저 설정해주세요',
                style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 32),
          _SettingsMenuTile(
            emoji: '🎯',
            title: '목표 설정',
            subtitle: '장기 저축 목표, 목표 주기, 주기별 목표 금액',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const GoalSettingsScreen()),
            ),
          ),
          _SettingsMenuTile(
            emoji: '🎨',
            title: '테마 설정',
            subtitle: '화면 모드 및 주스 테마',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ThemeSettingsScreen()),
            ),
          ),
          _SettingsMenuTile(
            emoji: '📱',
            title: '위젯 설정',
            subtitle: '홈 화면 위젯 금액 가리기',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const WidgetSettingsScreen()),
            ),
          ),
          _SettingsMenuTile(
            emoji: '💾',
            title: '데이터 백업 및 복원',
            subtitle: 'CSV 내보내기, 백업 파일 내보내기/불러오기',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const BackupSettingsScreen()),
            ),
          ),
          _SettingsMenuTile(
            emoji: '🔒',
            title: '보안',
            subtitle: 'PIN 번호, 생체인증',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SecuritySettingsScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsMenuTile extends StatelessWidget {
  const _SettingsMenuTile({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: Text(emoji, style: const TextStyle(fontSize: 22)),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }
}
