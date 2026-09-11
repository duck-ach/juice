import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../providers/app_lock_provider.dart';
import 'widgets/pin_dots.dart';
import 'widgets/pin_keypad.dart';

/// 앱 최초 진입/포그라운드 복귀 시 전체 화면을 덮는 잠금 해제 화면.
/// 생체인증이 켜져 있으면 진입 즉시 자동으로 시도하고, 실패/취소 시 PIN 입력으로 전환한다.
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key, required this.onUnlocked});

  final VoidCallback onUnlocked;

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  String _input = '';
  String? _error;
  bool _biometricInFlight = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryBiometric());
  }

  Future<void> _tryBiometric() async {
    if (!ref.read(appLockProvider).biometricEnabled || _biometricInFlight)
      return;
    setState(() => _biometricInFlight = true);
    try {
      final ok = await LocalAuthentication().authenticate(
        localizedReason: '주스 잠금을 해제해주세요',
        options: const AuthenticationOptions(stickyAuth: true),
      );
      if (ok) widget.onUnlocked();
    } catch (_) {
      // 미지원/실패/취소 — PIN 입력으로 진행.
    } finally {
      if (mounted) setState(() => _biometricInFlight = false);
    }
  }

  Future<void> _onDigit(String digit) async {
    if (_input.length >= 4) return;
    setState(() {
      _input += digit;
      _error = null;
    });
    if (_input.length == 4) {
      final ok = await ref.read(appLockProvider.notifier).verifyPin(_input);
      if (!mounted) return;
      if (ok) {
        widget.onUnlocked();
      } else {
        setState(() {
          _error = '비밀번호가 일치하지 않아요';
          _input = '';
        });
      }
    }
  }

  void _onBackspace() {
    if (_input.isEmpty) return;
    setState(() => _input = _input.substring(0, _input.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    final biometricEnabled = ref.watch(appLockProvider).biometricEnabled;

    return Material(
      color: const Color(0xFF121212),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 72),
            const Text('🍊', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            const Text('주스 잠금',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
              _error ?? 'PIN 4자리를 입력해주세요',
              style: TextStyle(
                color:
                    _error != null ? const Color(0xFFFF3B30) : Colors.white54,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 32),
            PinDots(length: 4, filled: _input.length),
            const Spacer(),
            PinKeypad(onDigit: _onDigit, onBackspace: _onBackspace),
            const SizedBox(height: 20),
            if (biometricEnabled)
              TextButton.icon(
                onPressed: _tryBiometric,
                icon: const Icon(Icons.fingerprint, color: Colors.white70),
                label: const Text('생체인증으로 잠금 해제',
                    style: TextStyle(color: Colors.white70)),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
