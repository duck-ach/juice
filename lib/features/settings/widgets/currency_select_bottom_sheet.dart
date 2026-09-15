import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/navigation/root_navigator.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/currency_provider.dart';
import '../../../services/currency_migration_service.dart';

/// 설정 > 통화 단위 설정에서 여는 바텀시트. 기준 통화를 바꾸면 먼저 확인을 받고,
/// 확인하면 기존 지출/수입/예산 금액을 새 통화로 일괄 환산(CurrencyMigrationService)한
/// 뒤 currencyProvider를 갱신한다.
class CurrencySelectBottomSheet extends ConsumerWidget {
  const CurrencySelectBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const CurrencySelectBottomSheet(),
    );
  }

  Future<void> _selectCurrency(
    BuildContext context,
    WidgetRef ref,
    CurrencyItem from,
    CurrencyItem to,
  ) async {
    final loc = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(loc.settingsCurrency),
        content: Text(loc.currencyMigrationConfirmMessage(to.code)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(loc.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(loc.commonConfirm),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    if (!context.mounted) return;
    Navigator.of(context).pop();

    final rootContext = rootNavigatorKey.currentContext;
    if (rootContext == null) return;

    showDialog<void>(
      context: rootContext,
      barrierDismissible: false,
      // ignore: deprecated_member_use
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text(loc.currencyMigrationLoadingMessage)),
            ],
          ),
        ),
      ),
    );

    final success = await CurrencyMigrationService.migrateBaseCurrency(
      ref,
      fromCode: from.code,
      toCode: to.code,
    );
    await ref.read(currencyProvider.notifier).select(to);

    Navigator.of(rootContext, rootNavigator: true).pop();
    if (!success) {
      ScaffoldMessenger.of(rootContext).showSnackBar(
        SnackBar(content: Text(loc.currencyMigrationFailedMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final current = ref.watch(currencyProvider).currency;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.settingsCurrency,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                border: Border.all(
                    color: const Color(0xFFFF9500).withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline,
                      color: Color(0xFFFF9500), size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      loc.currencyWarningNotice,
                      style: const TextStyle(fontSize: 12.5, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            for (final option in currencyPresets)
              RadioListTile<String>(
                value: option.code,
                groupValue: current.code,
                title: Text('${option.symbol}  ${option.displayName(loc)}'),
                onChanged: (_) {
                  if (option.code == current.code) return;
                  _selectCurrency(context, ref, current, option);
                },
              ),
          ],
        ),
      ),
    );
  }
}
