import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/csv_export.dart';
import '../../core/utils/thousands_formatter.dart';
import '../../core/utils/week_utils.dart';
import '../../data/models/budget_period.dart';
import '../../data/models/juice_theme.dart';
import '../../providers/budget_settings_provider.dart';
import '../../providers/category_provider.dart';
import '../../providers/expense_provider.dart';
import '../../providers/home_widget_settings_provider.dart';
import '../../providers/juice_theme_provider.dart';
import '../../providers/theme_provider.dart';
import 'widgets/savings_card.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _cardKey = GlobalKey();
  bool _sharingCard = false;
  bool _exportingCsv = false;

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

  Future<void> _exportCsv() async {
    setState(() => _exportingCsv = true);
    try {
      final expenses = ref.read(expenseProvider);
      final categories = ref.read(categoryProvider);
      final categoryMap = {for (final c in categories) c.id: c};
      final file = await buildExpenseCsvFile(expenses, categoryMap);
      await Share.shareXFiles([XFile(file.path)], text: '주스 지출 내역');
    } finally {
      if (mounted) setState(() => _exportingCsv = false);
    }
  }

  Future<void> _editTargetAmount() async {
    final current = ref.read(targetAmountProvider) ?? 0;
    final controller =
        TextEditingController(text: NumberFormat('#,###').format(current));
    final result = await showDialog<double>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('목표 금액 수정'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [ThousandsSeparatorInputFormatter()],
          textAlign: TextAlign.center,
          decoration: const InputDecoration(suffixText: 'mL'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () {
              final amount =
                  double.tryParse(controller.text.replaceAll(',', ''));
              Navigator.of(dialogContext).pop(amount);
            },
            child: const Text('저장'),
          ),
        ],
      ),
    );
    if (result != null && result > 0) {
      await ref.read(targetAmountProvider.notifier).setTargetAmount(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final juiceThemeType = ref.watch(juiceThemeTypeProvider);
    final hideWidgetAmount = ref.watch(hideWidgetAmountProvider);
    final budgetPeriod = ref.watch(budgetPeriodProvider);
    final targetAmount = ref.watch(targetAmountProvider);
    final spent = ref.watch(weeklySpentProvider);
    final range = currentWeekRange();
    final weekLabel =
        '${DateFormat('M.d').format(range.start)} - ${DateFormat('M.d').format(range.end)}';
    final formatter = NumberFormat('#,###');

    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text('목표 주기', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          SegmentedButton<BudgetPeriod>(
            segments: BudgetPeriod.values
                .map(
                    (p) => ButtonSegment(value: p, label: Text(p.settingLabel)))
                .toList(),
            selected: {budgetPeriod},
            onSelectionChanged: (selection) => ref
                .read(budgetPeriodProvider.notifier)
                .setPeriod(selection.first),
          ),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.local_drink_outlined),
              title: const Text('목표 금액'),
              subtitle: Text('${formatter.format(targetAmount ?? 0)} mL'),
              trailing: const Icon(Icons.chevron_right),
              onTap: _editTargetAmount,
            ),
          ),
          const SizedBox(height: 32),
          Text('테마', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(value: ThemeMode.system, label: Text('시스템')),
              ButtonSegment(value: ThemeMode.light, label: Text('라이트')),
              ButtonSegment(value: ThemeMode.dark, label: Text('다크')),
            ],
            selected: {themeMode},
            onSelectionChanged: (selection) => ref
                .read(themeModeProvider.notifier)
                .setThemeMode(selection.first),
          ),
          const SizedBox(height: 32),
          Text('주스 테마', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '잔여량에 따라 색이 바뀌는 홈 화면 주스 색을 골라보세요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: juiceThemes.map((theme) {
              final selected = theme.type == juiceThemeType;
              return _JuiceThemeOption(
                theme: theme,
                selected: selected,
                onTap: () => ref
                    .read(juiceThemeTypeProvider.notifier)
                    .setType(theme.type),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          Text('홈 화면 위젯', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '홈 화면에 주스 게이지 위젯과 빠른 입력 위젯을 추가할 수 있어요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: hideWidgetAmount,
            onChanged: (value) =>
                ref.read(hideWidgetAmountProvider.notifier).setHidden(value),
            title: const Text('위젯에서 금액 가리기'),
            subtitle: const Text('금액 대신 ***mL와 잔여 % 수위만 표시해요.'),
          ),
          const SizedBox(height: 32),
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
          Text('지출 내역 내보내기', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '날짜, 카테고리, 금액, 고정지출 여부, 메모가 담긴 CSV 파일을 공유해요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 52,
            child: OutlinedButton.icon(
              onPressed: _exportingCsv ? null : _exportCsv,
              icon: const Icon(Icons.table_chart_outlined),
              label: Text(_exportingCsv ? '내보내는 중...' : 'CSV로 내보내기'),
            ),
          ),
        ],
      ),
    );
  }
}

/// 설정 화면의 주스 테마 선택 카드. 3단계 색상을 미리보기 스트립으로 보여준다.
class _JuiceThemeOption extends StatelessWidget {
  const _JuiceThemeOption(
      {required this.theme, required this.selected, required this.onTap});

  final JuiceTheme theme;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 96,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? colorScheme.primary : colorScheme.outlineVariant,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(theme.emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Row(
                children: [
                  Expanded(child: Container(height: 8, color: theme.highColor)),
                  Expanded(
                      child: Container(height: 8, color: theme.mediumColor)),
                  Expanded(child: Container(height: 8, color: theme.lowColor)),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              theme.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
