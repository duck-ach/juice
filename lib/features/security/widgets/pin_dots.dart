import 'package:flutter/material.dart';

/// 4자리 PIN 입력 진행 상태를 보여주는 원형 인디케이터(●○○○).
class PinDots extends StatelessWidget {
  const PinDots(
      {super.key,
      required this.length,
      required this.filled,
      this.color = Colors.white});

  final int length;
  final int filled;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(length, (i) {
        final isFilled = i < filled;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled ? color : Colors.transparent,
            border: Border.all(color: color, width: 1.5),
          ),
        );
      }),
    );
  }
}
