import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/app_lock_provider.dart';
import 'lock_screen.dart';

/// 앱 잠금이 켜져 있으면 앱 최초 진입/포그라운드 복귀 시 [LockScreen]으로 화면을 덮는다.
/// 잠금이 꺼져 있으면 아무 영향 없이 [child]를 그대로 보여준다.
class AppLockGate extends ConsumerStatefulWidget {
  const AppLockGate({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends ConsumerState<AppLockGate>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        ref.read(appLockProvider).enabled) {
      ref.read(isLockedProvider.notifier).state = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lockEnabled = ref.watch(appLockProvider).enabled;
    final locked = ref.watch(isLockedProvider);

    return Stack(
      children: [
        widget.child,
        if (lockEnabled && locked)
          Positioned.fill(
            child: LockScreen(
                onUnlocked: () =>
                    ref.read(isLockedProvider.notifier).state = false),
          ),
      ],
    );
  }
}
