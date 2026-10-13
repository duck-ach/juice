import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:juice/core/responsive/responsive.dart';

DisplayFeature _feature(Rect bounds,
        {DisplayFeatureType type = DisplayFeatureType.hinge,
        DisplayFeatureState state = DisplayFeatureState.postureHalfOpened}) =>
    DisplayFeature(bounds: bounds, type: type, state: state);

Widget _host(Widget child,
        {required Size size, List<DisplayFeature>? features}) =>
    MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(size: size, displayFeatures: features ?? const []),
        child: child,
      ),
    );

void main() {
  test('너비 기준 창 크기 분류 경계값', () {
    expect(WindowSizeClass.fromWidth(599.9), WindowSizeClass.compact);
    expect(WindowSizeClass.fromWidth(600), WindowSizeClass.medium);
    expect(WindowSizeClass.fromWidth(839.9), WindowSizeClass.medium);
    expect(WindowSizeClass.fromWidth(840), WindowSizeClass.expanded);
  });

  group('FoldInfo', () {
    test('폴드 피처가 없으면 flat', () {
      expect(FoldInfo.fromDisplayFeatures(const []).posture, FoldPosture.flat);
    });

    test('세로 힌지(반쯤 접힘)는 book, 가로 힌지는 tabletop', () {
      final book = FoldInfo.fromDisplayFeatures(
          [_feature(const Rect.fromLTWH(390, 0, 20, 800))]);
      expect(book.posture, FoldPosture.book);
      expect(book.hinge, const Rect.fromLTWH(390, 0, 20, 800));

      final tabletop = FoldInfo.fromDisplayFeatures(
          [_feature(const Rect.fromLTWH(0, 390, 800, 20))]);
      expect(tabletop.posture, FoldPosture.tabletop);
    });

    test('완전히 펼쳐진 폴드(분리 없음)는 flat이지만 힌지 영역은 유지', () {
      final info = FoldInfo.fromDisplayFeatures([
        _feature(const Rect.fromLTWH(400, 0, 0, 800),
            type: DisplayFeatureType.fold,
            state: DisplayFeatureState.postureFlat),
      ]);
      expect(info.posture, FoldPosture.flat);
      expect(info.hinge, isNotNull);
    });
  });

  testWidgets('ResponsiveLayout은 분류별 빌더를 고르고 없으면 한 단계 아래로 대체', (tester) async {
    Widget layout() => ResponsiveLayout(
          compact: (_) => const Text('compact'),
          medium: (_) => const Text('medium'),
        );

    await tester.pumpWidget(_host(layout(), size: const Size(400, 800)));
    expect(find.text('compact'), findsOneWidget);

    await tester.pumpWidget(_host(layout(), size: const Size(700, 900)));
    expect(find.text('medium'), findsOneWidget);

    await tester.pumpWidget(_host(layout(), size: const Size(1000, 700)));
    expect(find.text('medium'), findsOneWidget); // expanded 미지정 → medium
  });

  testWidgets('TwoPane: book 자세는 힌지 좌표대로 좌/우를 나눈다', (tester) async {
    await tester.pumpWidget(_host(
      const TwoPane(
          primary: Placeholder(key: Key('a')),
          secondary: Placeholder(key: Key('b'))),
      size: const Size(800, 600),
      features: [_feature(const Rect.fromLTWH(390, 0, 20, 600))],
    ));
    await tester.pump();
    expect(tester.getSize(find.byKey(const Key('a'))).width, 390);
    expect(tester.getTopLeft(find.byKey(const Key('b'))).dx, 410);
  });

  testWidgets('TwoPane: tabletop 자세는 힌지 높이대로 위/아래를 나눈다', (tester) async {
    await tester.pumpWidget(_host(
      const TwoPane(
          primary: Placeholder(key: Key('a')),
          secondary: Placeholder(key: Key('b'))),
      size: const Size(800, 800),
      features: [_feature(const Rect.fromLTWH(0, 390, 800, 20))],
    ));
    await tester.pump();
    expect(tester.getSize(find.byKey(const Key('a'))).height, 390);
    expect(tester.getTopLeft(find.byKey(const Key('b'))).dy, 410);
  });

  testWidgets('TwoPane: 일반 태블릿은 4:6 비율로 나눈다', (tester) async {
    // MediaQuery 값과 실제 레이아웃 크기를 맞추기 위해 테스트 뷰 크기를 직접 지정한다.
    tester.view.physicalSize = const Size(1001, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_host(
      const TwoPane(
          primary: Placeholder(key: Key('a')),
          secondary: Placeholder(key: Key('b'))),
      size: const Size(1001, 600),
    ));
    expect(tester.getSize(find.byKey(const Key('a'))).width, closeTo(400, 1));
  });
}
