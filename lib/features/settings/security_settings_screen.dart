import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/app_lock_provider.dart';
import '../security/pin_flow_screen.dart';

/// PIN + 생체인증 보안 설정 서브 화면.
class SecuritySettingsScreen extends ConsumerStatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  ConsumerState<SecuritySettingsScreen> createState() =>
      _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState
    extends ConsumerState<SecuritySettingsScreen> {
  bool _biometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      final auth = LocalAuthentication();
      final supported = await auth.isDeviceSupported();
      final canCheck = await auth.canCheckBiometrics;
      if (mounted) setState(() => _biometricAvailable = supported && canCheck);
    } catch (_) {
      // 생체인증 미지원 기기 — 토글을 숨긴 채로 둔다.
    }
  }

  Future<void> _enableAppLock() async {
    final loc = AppLocalizations.of(context)!;
    final pin = await showPinFlow<String>(context,
        mode: PinFlowMode.setup, title: loc.pinSetupTitle);
    if (pin != null) {
      await ref.read(appLockProvider.notifier).enableLock(pin);
    }
  }

  Future<void> _disableAppLock() async {
    final loc = AppLocalizations.of(context)!;
    final biometricEnabled = ref.read(appLockProvider).biometricEnabled;
    var verified = false;
    if (biometricEnabled) {
      try {
        verified = await LocalAuthentication()
            .authenticate(localizedReason: loc.biometricUnlockReason);
      } catch (_) {
        verified = false;
      }
    }
    if (!verified && mounted) {
      verified = await showPinFlow<bool>(context,
              mode: PinFlowMode.verify, title: loc.pinConfirmTitle) ??
          false;
    }
    if (verified) {
      await ref.read(appLockProvider.notifier).disableLock();
    }
  }

  Future<void> _changeAppLockPin() async {
    final loc = AppLocalizations.of(context)!;
    final verified = await showPinFlow<bool>(context,
            mode: PinFlowMode.verify, title: loc.pinConfirmCurrentTitle) ??
        false;
    if (!verified || !mounted) return;
    final newPin = await showPinFlow<String>(context,
        mode: PinFlowMode.setup, title: loc.pinSetupNewTitle);
    if (newPin != null) {
      await ref.read(appLockProvider.notifier).changePin(newPin);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(loc.pinChangedMessage)));
      }
    }
  }

  Future<void> _toggleBiometric(bool value) async {
    final loc = AppLocalizations.of(context)!;
    if (!value) {
      await ref.read(appLockProvider.notifier).setBiometricEnabled(false);
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(loc.biometricLinkTitle),
        content: Text(loc.biometricLinkConfirm),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(loc.commonCancel)),
          FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(loc.biometricLinkAction)),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      final ok = await LocalAuthentication()
          .authenticate(localizedReason: loc.biometricLinkReason);
      if (ok) {
        await ref.read(appLockProvider.notifier).setBiometricEnabled(true);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(loc.biometricUnavailableMessage)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final appLock = ref.watch(appLockProvider);

    return Scaffold(
      appBar: AppBar(title: Text(loc.securityTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text(loc.securityTitle, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(loc.securityDescription,
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                SwitchListTile(
                  value: appLock.enabled,
                  onChanged: (value) =>
                      value ? _enableAppLock() : _disableAppLock(),
                  title: Text(loc.appLockTitle),
                  subtitle: Text(loc.appLockDescription),
                ),
                if (appLock.enabled) ...[
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.password_outlined),
                    title: Text(loc.changePasswordTitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _changeAppLockPin,
                  ),
                  if (_biometricAvailable) ...[
                    const Divider(height: 1),
                    SwitchListTile(
                      value: appLock.biometricEnabled,
                      onChanged: _toggleBiometric,
                      title: Text(loc.biometricUseTitle),
                      subtitle: Text(loc.biometricUseDescription),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
