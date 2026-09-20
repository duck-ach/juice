import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import '../../core/constants/app_links.dart';
import '../../core/utils/week_utils.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/budget_settings_provider.dart';
import '../../providers/currency_provider.dart';
import '../../providers/expense_provider.dart';
import '../../providers/juice_theme_provider.dart';
import '../../providers/locale_provider.dart';
import 'backup_settings_screen.dart';
import 'card_management_screen.dart';
import 'goal_settings_screen.dart';
import 'notification_settings_screen.dart';
import 'security_settings_screen.dart';
import 'theme_settings_screen.dart';
import 'widget_settings_screen.dart';
import 'widgets/currency_select_bottom_sheet.dart';
import 'widgets/language_select_bottom_sheet.dart';
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
      if (!mounted) return;
      await Share.shareXFiles([XFile(file.path)],
          text: AppLocalizations.of(context)!.shareCardText);
    } finally {
      if (mounted) setState(() => _sharingCard = false);
    }
  }

  /// [uri]를 열어 줄 앱(메일/브라우저 등)이 기기에 없으면 launchUrl이 아무 표시 없이
  /// false를 반환하거나(시뮬레이터에서 메일 계정 미설정 등) 플랫폼에 따라 예외를 던지고
  /// 끝나버린다 — 탭해도 반응이 없는 것처럼 보이는 원인. 두 경우 모두 잡아 대상
  /// (이메일/URL)을 스낵바로 보여주고 복사할 수 있게 해 항상 피드백을 준다.
  Future<void> _launchOrShowFallback(Uri uri, String displayTarget,
      {LaunchMode? mode}) async {
    var launched = false;
    try {
      launched = await launchUrl(uri, mode: mode ?? LaunchMode.platformDefault);
    } catch (_) {
      launched = false;
    }
    if (launched || !mounted) return;
    final loc = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(loc.linkOpenFailedMessage(displayTarget)),
        action: SnackBarAction(
          label: loc.commonCopy,
          onPressed: () =>
              Clipboard.setData(ClipboardData(text: displayTarget)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final weekStartDay = ref.watch(weekStartDayProvider);
    final targetAmount = ref.watch(targetAmountProvider);
    final spent = ref.watch(weeklySpentProvider);
    final range = currentWeekRange(null, weekStartDay);
    final weekLabel =
        '${DateFormat('M.d').format(range.start)} - ${DateFormat('M.d').format(range.end)}';
    final currentLanguage = ref.watch(localeProvider).locale;
    final currentLanguageName = supportedLanguageOptions
        .firstWhere((o) => o.locale.languageCode == currentLanguage.languageCode,
            orElse: () => supportedLanguageOptions.first)
        .nativeName;
    final currentCurrency = ref.watch(currencyProvider).currency;
    final currentJuiceTheme = ref.watch(resolvedJuiceThemeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(loc.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text(loc.savingsCardSectionTitle,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            loc.savingsCardSectionDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          if (targetAmount != null) ...[
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: RepaintBoundary(
                key: _cardKey,
                child: SavingsCard(
                    budget: targetAmount,
                    spent: spent,
                    weekLabel: weekLabel,
                    currency: currentCurrency,
                    theme: currentJuiceTheme),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _sharingCard ? null : _shareCard,
                icon: const Icon(Icons.ios_share),
                label: Text(_sharingCard
                    ? loc.generatingCard
                    : loc.shareCardButton),
              ),
            ),
          ] else
            Text(loc.setTargetAmountFirst,
                style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 32),
          _SettingsValueTile(
            icon: Icons.language,
            title: loc.settingsLanguage,
            value: currentLanguageName,
            onTap: () => LanguageSelectBottomSheet.show(context),
          ),
          _SettingsValueTile(
            icon: Icons.attach_money,
            title: loc.settingsCurrency,
            value: '${currentCurrency.symbol} ${currentCurrency.code}',
            onTap: () => CurrencySelectBottomSheet.show(context),
          ),
          const SizedBox(height: 8),
          _SettingsMenuTile(
            emoji: '🎯',
            title: loc.menuGoalSettingsTitle,
            subtitle: loc.menuGoalSettingsSubtitle,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const GoalSettingsScreen()),
            ),
          ),
          _SettingsMenuTile(
            emoji: '🎨',
            title: loc.menuThemeSettingsTitle,
            subtitle: loc.menuThemeSettingsSubtitle,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ThemeSettingsScreen()),
            ),
          ),
          _SettingsMenuTile(
            emoji: '📱',
            title: loc.menuWidgetSettingsTitle,
            subtitle: loc.menuWidgetSettingsSubtitle,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const WidgetSettingsScreen()),
            ),
          ),
          _SettingsMenuTile(
            emoji: '💳',
            title: loc.menuCardManagementTitle,
            subtitle: loc.menuCardManagementSubtitle,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CardManagementScreen()),
            ),
          ),
          _SettingsMenuTile(
            emoji: '🔔',
            title: loc.menuNotificationSettingsTitle,
            subtitle: loc.menuNotificationSettingsSubtitle,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => const NotificationSettingsScreen()),
            ),
          ),
          _SettingsMenuTile(
            emoji: '💾',
            title: loc.menuBackupSettingsTitle,
            subtitle: loc.menuBackupSettingsSubtitle,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const BackupSettingsScreen()),
            ),
          ),
          _SettingsMenuTile(
            emoji: '🔒',
            title: loc.menuSecuritySettingsTitle,
            subtitle: loc.menuSecuritySettingsSubtitle,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SecuritySettingsScreen()),
            ),
          ),
          _SettingsMenuTile(
            emoji: '✉️',
            title: loc.menuContactSupportTitle,
            subtitle: loc.menuContactSupportSubtitle,
            onTap: () => _launchOrShowFallback(
                AppLinks.supportEmailUri, AppLinks.supportEmail),
          ),
          _SettingsMenuTile(
            emoji: '📄',
            title: loc.privacyPolicyTitle,
            subtitle: loc.menuPrivacyPolicySubtitle,
            onTap: () => _launchOrShowFallback(
                Uri.parse(AppLinks.privacyPolicyUrl), AppLinks.privacyPolicyUrl,
                mode: LaunchMode.externalApplication),
          ),
        ],
      ),
    );
  }
}

/// 언어/통화처럼 "현재 값"을 트레일링에 보여주고 탭하면 바텀시트를 여는 설정 타일.
class _SettingsValueTile extends StatelessWidget {
  const _SettingsValueTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right),
            ],
          ),
          onTap: onTap,
        ),
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
