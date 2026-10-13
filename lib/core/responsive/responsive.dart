import 'package:flutter/material.dart';

import 'fold_state.dart';
import 'window_size_class.dart';

export 'fold_state.dart';
export 'window_size_class.dart';

/// 현재 창 크기 분류 + 폴더블 상태를 한데 묶은 값. 위젯은 이것만 보고 레이아웃을 분기한다.
class ResponsiveInfo {
  const ResponsiveInfo({
    required this.size,
    required this.sizeClass,
    required this.fold,
  });

  factory ResponsiveInfo.of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ResponsiveInfo(
      size: size,
      sizeClass: WindowSizeClass.fromWidth(size.width),
      fold: FoldInfo.fromDisplayFeatures(MediaQuery.displayFeaturesOf(context)),
    );
  }

  final Size size;
  final WindowSizeClass sizeClass;
  final FoldInfo fold;

  /// 한 화면에 두 영역(요약 | 목록)을 나란히/위아래로 놓을 수 있는지.
  /// 폴더블 접힘 자세이거나, 일반 화면이라도 너비가 medium 이상이면 true.
  bool get useTwoPane => fold.isFolded || sizeClass.isMediumUp;

  /// 하단 탭바 대신 내비게이션 레일을 쓸지. 세로 힌지(book)는 힌지가 레일 위에 걸릴 수 있어
  /// 하단 탭바를 유지한다.
  bool get useNavigationRail =>
      sizeClass.isMediumUp && fold.posture != FoldPosture.book;
}

extension ResponsiveContext on BuildContext {
  ResponsiveInfo get responsive => ResponsiveInfo.of(this);
}

/// 창 크기 분류별로 다른 위젯을 보여준다. [medium]/[expanded]를 생략하면 한 단계 작은
/// 분류의 위젯으로 대체된다(expanded → medium → compact).
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.compact,
    this.medium,
    this.expanded,
  });

  final WidgetBuilder compact;
  final WidgetBuilder? medium;
  final WidgetBuilder? expanded;

  @override
  Widget build(BuildContext context) {
    final builder = switch (context.responsive.sizeClass) {
      WindowSizeClass.expanded => expanded ?? medium ?? compact,
      WindowSizeClass.medium => medium ?? compact,
      WindowSizeClass.compact => compact,
    };
    return builder(context);
  }
}

/// 넓은 화면에서 본문이 끝없이 퍼지지 않도록 가운데 정렬 + 최대 너비를 제한한다.
class ConstrainedContent extends StatelessWidget {
  const ConstrainedContent(
      {super.key, required this.child, this.maxWidth = 720});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      );
}

/// 두 영역을 나눠 배치한다.
/// - [FoldPosture.book]: 세로 힌지를 기준으로 좌/우로 나누고 힌지 폭만큼 비운다.
/// - [FoldPosture.tabletop]: 가로 힌지를 기준으로 위/아래로 나눈다.
/// - 그 외(일반 태블릿 등): [primaryFlex]:[secondaryFlex] 비율로 좌/우 분할 + 구분선.
class TwoPane extends StatefulWidget {
  const TwoPane({
    super.key,
    required this.primary,
    required this.secondary,
    this.primaryFlex = 4,
    this.secondaryFlex = 6,
  });

  final Widget primary;
  final Widget secondary;
  final int primaryFlex;
  final int secondaryFlex;

  @override
  State<TwoPane> createState() => _TwoPaneState();
}

class _TwoPaneState extends State<TwoPane> {
  /// 이 위젯의 좌상단이 화면에서 놓인 위치. 힌지 좌표(화면 기준)를 로컬 좌표로 바꾸는 데 쓴다.
  Offset _origin = Offset.zero;

  void _measureOrigin() {
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.attached || !box.hasSize) return;
    final origin = box.localToGlobal(Offset.zero);
    if (origin != _origin && mounted) setState(() => _origin = origin);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureOrigin());
    final fold = context.responsive.fold;
    final hinge = fold.hinge;

    if (fold.posture == FoldPosture.book && hinge != null) {
      final left = (hinge.left - _origin.dx).clamp(0.0, double.infinity);
      return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(width: left, child: widget.primary),
        SizedBox(width: hinge.width),
        Expanded(child: widget.secondary),
      ]);
    }
    if (fold.posture == FoldPosture.tabletop && hinge != null) {
      final top = (hinge.top - _origin.dy).clamp(0.0, double.infinity);
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(height: top, child: widget.primary),
        SizedBox(height: hinge.height),
        Expanded(child: widget.secondary),
      ]);
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Expanded(flex: widget.primaryFlex, child: widget.primary),
      VerticalDivider(width: 1, color: Theme.of(context).dividerColor),
      Expanded(flex: widget.secondaryFlex, child: widget.secondary),
    ]);
  }
}
