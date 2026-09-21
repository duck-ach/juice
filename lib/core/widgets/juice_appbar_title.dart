import 'package:flutter/material.dart';

/// AppBar 타이틀 전용 오버플로우 방어 래퍼. 독일어("Einstellungen") 등 긴 번역 문자열이
/// 들어와도 폰트 크기를 유지한 채 필요한 만큼만 자동 축소되고(FittedBox), 그래도 넘치면
/// 말줄임 처리해 상단 바 영역 밖으로 잘리거나 두 줄로 줄바꿈되는 것을 막는다.
class JuiceAppBarTitle extends StatelessWidget {
  const JuiceAppBarTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
