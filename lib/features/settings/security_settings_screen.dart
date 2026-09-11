import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

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
    final pin = await showPinFlow<String>(context,
        mode: PinFlowMode.setup, title: '비밀번호 설정');
    if (pin != null) {
      await ref.read(appLockProvider.notifier).enableLock(pin);
    }
  }

  Future<void> _disableAppLock() async {
    final biometricEnabled = ref.read(appLockProvider).biometricEnabled;
    var verified = false;
    if (biometricEnabled) {
      try {
        verified = await LocalAuthentication()
            .authenticate(localizedReason: '잠금을 해제하려면 인증해주세요');
      } catch (_) {
        verified = false;
      }
    }
    if (!verified && mounted) {
      verified = await showPinFlow<bool>(context,
              mode: PinFlowMode.verify, title: '비밀번호 확인') ??
          false;
    }
    if (verified) {
      await ref.read(appLockProvider.notifier).disableLock();
    }
  }

  Future<void> _changeAppLockPin() async {
    final verified = await showPinFlow<bool>(context,
            mode: PinFlowMode.verify, title: '현재 비밀번호 확인') ??
        false;
    if (!verified || !mounted) return;
    final newPin = await showPinFlow<String>(context,
        mode: PinFlowMode.setup, title: '새 비밀번호 설정');
    if (newPin != null) {
      await ref.read(appLockProvider.notifier).changePin(newPin);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('비밀번호가 변경되었어요')));
      }
    }
  }

  Future<void> _toggleBiometric(bool value) async {
    if (!value) {
      await ref.read(appLockProvider.notifier).setBiometricEnabled(false);
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('생체인증 연동'),
        content: const Text('생체인증을 연동하시겠습니까?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('취소')),
          FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('연동')),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      final ok = await LocalAuthentication()
          .authenticate(localizedReason: '생체인증을 연동하려면 인증해주세요');
      if (ok) {
        await ref.read(appLockProvider.notifier).setBiometricEnabled(true);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('생체인증을 사용할 수 없어요')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLock = ref.watch(appLockProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('보안')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          Text('보안', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text('PIN 번호와 생체인증으로 앱을 잠글 수 있어요.',
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
                  title: const Text('앱 잠금'),
                  subtitle: const Text('PIN 4자리로 앱 진입을 보호해요.'),
                ),
                if (appLock.enabled) ...[
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.password_outlined),
                    title: const Text('비밀번호 변경'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _changeAppLockPin,
                  ),
                  if (_biometricAvailable) ...[
                    const Divider(height: 1),
                    SwitchListTile(
                      value: appLock.biometricEnabled,
                      onChanged: _toggleBiometric,
                      title: const Text('생체인증 사용'),
                      subtitle: const Text('Face ID/지문으로 더 빠르게 잠금을 해제해요.'),
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
