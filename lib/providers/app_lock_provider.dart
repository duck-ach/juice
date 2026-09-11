import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../data/local/hive_service.dart';

const _appLockEnabledKey = 'appLockEnabled';
const _biometricEnabledKey = 'biometricEnabled';
const _pinSecureKey = 'app_lock_pin';

const _secureStorage = FlutterSecureStorage();

class AppLockState {
  const AppLockState({required this.enabled, required this.biometricEnabled});

  final bool enabled;
  final bool biometricEnabled;

  AppLockState copyWith({bool? enabled, bool? biometricEnabled}) =>
      AppLockState(
        enabled: enabled ?? this.enabled,
        biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      );
}

/// 앱 잠금(PIN/생체인증) 설정 상태. PIN 자체는 flutter_secure_storage(Keychain/Keystore)에만 저장하고,
/// on/off 플래그만 Hive 설정 박스에 둔다.
class AppLockNotifier extends Notifier<AppLockState> {
  @override
  AppLockState build() {
    final box = Hive.box(HiveBoxes.settings);
    return AppLockState(
      enabled: (box.get(_appLockEnabledKey) as bool?) ?? false,
      biometricEnabled: (box.get(_biometricEnabledKey) as bool?) ?? false,
    );
  }

  Future<String?> _currentPin() => _secureStorage.read(key: _pinSecureKey);

  Future<bool> verifyPin(String pin) async {
    final saved = await _currentPin();
    return saved != null && saved == pin;
  }

  /// 새 PIN을 저장하고 잠금을 켠다.
  Future<void> enableLock(String pin) async {
    await _secureStorage.write(key: _pinSecureKey, value: pin);
    await Hive.box(HiveBoxes.settings).put(_appLockEnabledKey, true);
    state = state.copyWith(enabled: true);
  }

  /// 인증이 끝난 뒤 호출 — 저장된 PIN/생체인증 플래그를 모두 초기화하고 잠금을 끈다.
  Future<void> disableLock() async {
    await _secureStorage.delete(key: _pinSecureKey);
    await Hive.box(HiveBoxes.settings).put(_appLockEnabledKey, false);
    await Hive.box(HiveBoxes.settings).put(_biometricEnabledKey, false);
    state = const AppLockState(enabled: false, biometricEnabled: false);
  }

  Future<void> changePin(String newPin) async {
    await _secureStorage.write(key: _pinSecureKey, value: newPin);
  }

  Future<void> setBiometricEnabled(bool value) async {
    await Hive.box(HiveBoxes.settings).put(_biometricEnabledKey, value);
    state = state.copyWith(biometricEnabled: value);
  }
}

final appLockProvider =
    NotifierProvider<AppLockNotifier, AppLockState>(AppLockNotifier.new);

/// 이번 세션에서 아직 잠금 해제 전인지. 앱 시작 시 잠금이 켜져 있으면 잠긴 채로 시작하고,
/// 포그라운드 복귀 시([AppLockGate])에도 다시 true로 세팅된다.
final isLockedProvider =
    StateProvider<bool>((ref) => ref.read(appLockProvider).enabled);
