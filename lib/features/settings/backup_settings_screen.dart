import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/csv_export.dart';
import '../../data/local/backup_service.dart';
import '../../providers/budget_settings_provider.dart';
import '../../providers/category_provider.dart';
import '../../providers/expense_provider.dart';
import '../../providers/home_widget_settings_provider.dart';
import '../../providers/juice_theme_provider.dart';
import '../../providers/theme_provider.dart';

/// 데이터 내보내기(CSV)/백업/복원 서브 화면.
class BackupSettingsScreen extends ConsumerStatefulWidget {
  const BackupSettingsScreen({super.key});

  @override
  ConsumerState<BackupSettingsScreen> createState() =>
      _BackupSettingsScreenState();
}

class _BackupSettingsScreenState extends ConsumerState<BackupSettingsScreen> {
  bool _exportingCsv = false;
  bool _backingUp = false;
  bool _restoring = false;

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

  Future<void> _backupData() async {
    setState(() => _backingUp = true);
    try {
      final json = BackupService.buildBackupJson();
      final dir = await getTemporaryDirectory();
      final filename =
          'juice_backup_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.json';
      final file = File('${dir.path}/$filename');
      await file
          .writeAsString(const JsonEncoder.withIndent('  ').convert(json));
      await Share.shareXFiles([XFile(file.path)], text: '주스 데이터 백업');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('백업에 실패했어요: $e')));
      }
    } finally {
      if (mounted) setState(() => _backingUp = false);
    }
  }

  Future<void> _restoreData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('데이터 복원'),
        content: const Text('기존 데이터가 백업 파일 내용으로 대체됩니다. 계속할까요?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('취소')),
          FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('복원')),
        ],
      ),
    );
    if (confirmed != true) return;

    final result = await FilePicker.pickFiles(
        type: FileType.custom, allowedExtensions: ['json', 'juice']);
    final path = result?.files.single.path;
    if (path == null) return;

    setState(() => _restoring = true);
    try {
      final content = await File(path).readAsString();
      final json = jsonDecode(content) as Map<String, dynamic>;
      await BackupService.restoreFromJson(json);
      _refreshAllProviders();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('복원이 완료됐어요')));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('복원에 실패했어요. 올바른 주스 백업 파일인지 확인해주세요')),
        );
      }
    } finally {
      if (mounted) setState(() => _restoring = false);
    }
  }

  void _refreshAllProviders() {
    ref.invalidate(categoryProvider);
    ref.invalidate(expenseProvider);
    ref.invalidate(budgetPeriodProvider);
    ref.invalidate(periodTargetAmountsProvider);
    ref.invalidate(weekStartDayProvider);
    ref.invalidate(juiceThemeTypeProvider);
    ref.invalidate(themeModeProvider);
    ref.invalidate(hideWidgetAmountProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('데이터 백업 및 복원')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
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
          const SizedBox(height: 32),
          Text('데이터 백업 · 복원', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '지출/수입 내역, 카테고리, 예산 설정을 파일 하나로 백업하고 복원할 수 있어요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.upload_file_outlined),
              title: const Text('데이터 백업하기'),
              subtitle: const Text('공유창을 통해 파일 앱, 이메일 등으로 저장해요.'),
              trailing: _backingUp
                  ? const _SmallSpinner()
                  : const Icon(Icons.chevron_right),
              onTap: _backingUp ? null : _backupData,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.download_outlined),
              title: const Text('데이터 복원하기'),
              subtitle: const Text('백업 파일을 선택해 기존 데이터를 덮어써요.'),
              trailing: _restoring
                  ? const _SmallSpinner()
                  : const Icon(Icons.chevron_right),
              onTap: _restoring ? null : _restoreData,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallSpinner extends StatelessWidget {
  const _SmallSpinner();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2));
  }
}
