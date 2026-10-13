import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 하위 트리를 통째로 새로 만든다(ProviderScope 재생성 → 모든 provider가 저장소에서 다시 읽힘).
/// "전체 데이터 초기화" 직후처럼 앱 상태를 처음부터 다시 구성해야 할 때 쓴다.
class AppRestart extends StatefulWidget {
  const AppRestart({super.key, required this.child});

  final Widget child;

  static void restart(BuildContext context) =>
      context.findAncestorStateOfType<_AppRestartState>()?._restart();

  @override
  State<AppRestart> createState() => _AppRestartState();
}

class _AppRestartState extends State<AppRestart> {
  Key _key = UniqueKey();
  bool _visible = true;

  /// 한 프레임 동안 트리를 완전히 비운 뒤 다시 만든다. 곧바로 새 트리를 만들면 전역 키
  /// (rootNavigatorKey)를 쓰는 Navigator가 이전 라우트 스택을 그대로 물려받기 때문이다.
  void _restart() {
    setState(() => _visible = false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _key = UniqueKey();
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) => _visible
      ? ProviderScope(key: _key, child: widget.child)
      : const SizedBox.shrink();
}
