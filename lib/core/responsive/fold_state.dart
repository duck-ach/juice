import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:flutter/widgets.dart';

/// 폴더블 기기의 접힘/펼침 자세.
/// - [flat]: 폴드/힌지가 없거나 완전히 펼쳐진 상태(일반 화면으로 취급).
/// - [tabletop]: 가로 힌지가 반쯤 접힌 상태 — 화면이 위/아래로 나뉜다(노트북처럼 세워 둔 모습).
/// - [book]: 세로 힌지로 화면이 좌/우로 나뉜 상태(책을 펼친 모습).
enum FoldPosture { flat, tabletop, book }

/// [MediaQuery.displayFeatures]에서 뽑은 폴드 정보. 힌지 영역은 화면 전체 좌표계 기준이다.
class FoldInfo {
  const FoldInfo({required this.posture, this.hinge});

  /// 폴드가 없는 일반 기기.
  static const none = FoldInfo(posture: FoldPosture.flat);

  final FoldPosture posture;

  /// 힌지/폴드가 차지하는 영역(논리 픽셀, 화면 좌표). 폴드가 없으면 null.
  final Rect? hinge;

  bool get isFolded => posture != FoldPosture.flat;

  /// 첫 번째 폴드/힌지 피처로 자세를 판정한다. 접근 가능한 폴드 API가 없는 플랫폼(iOS 등)은
  /// 항상 [none].
  static FoldInfo fromDisplayFeatures(List<DisplayFeature> features) {
    for (final f in features) {
      if (f.type != DisplayFeatureType.fold &&
          f.type != DisplayFeatureType.hinge) {
        continue;
      }
      final bounds = f.bounds;
      final isVertical = bounds.height >= bounds.width;
      final separating = f.type == DisplayFeatureType.hinge ||
          f.state == DisplayFeatureState.postureHalfOpened;
      if (!separating) {
        return FoldInfo(posture: FoldPosture.flat, hinge: bounds);
      }
      return FoldInfo(
        posture: isVertical ? FoldPosture.book : FoldPosture.tabletop,
        hinge: bounds,
      );
    }
    return FoldInfo.none;
  }
}
