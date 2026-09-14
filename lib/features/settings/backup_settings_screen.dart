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
import '../../l10n/app_localizations.dart';
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
      if (!mounted) return;
      await Share.shareXFiles([XFile(file.path)],
          text: AppLocalizations.of(context)!.csvShareText);
    } finally {
      if (mounted) setState(() => _exportingCsv = false);
    }
  }

  Future<void> _backupData() async {
    final loc = AppLocalizations.of(context)!;
    setState(() => _backingUp = true);
    try {
      final json = BackupService.buildBackupJson();
      final dir = await getTemporaryDirectory();
      final filename =
          'juice_backup_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.json';
      final file = File('${dir.path}/$filename');
      await file
          .writeAsString(const JsonEncoder.withIndent('  ').convert(json));
      if (!mounted) return;
      await Share.shareXFiles([XFile(file.path)], text: loc.backupShareText);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(loc.backupFailedMessage(e.toString()))));
      }
    } finally {
      if (mounted) setState(() => _backingUp = false);
    }
  }

  Future<void> _restoreData() async {
    final loc = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(loc.restoreDataTitle),
        content: Text(loc.restoreDataConfirm),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(loc.commonCancel)),
          FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(loc.restoreAction)),
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
            .showSnackBar(SnackBar(content: Text(loc.restoreSuccessMessage)));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loc.restoreFailedMessage)),
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
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.backupSettingsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text(loc.exportExpensesTitle,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            loc.exportExpensesDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 52,
            child: OutlinedButton.icon(
              onPressed: _exportingCsv ? null : _exportCsv,
              icon: const Icon(Icons.table_chart_outlined),
              label: Text(_exportingCsv ? loc.exportingCsv : loc.exportCsvButton),
            ),
          ),
          const SizedBox(height: 32),
          Text(loc.backupRestoreTitle,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            loc.backupRestoreDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.upload_file_outlined),
              title: Text(loc.backupDataTitle),
              subtitle: Text(loc.backupDataDescription),
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
              title: Text(loc.restoreDataTileTitle),
              subtitle: Text(loc.restoreDataTileDescription),
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
