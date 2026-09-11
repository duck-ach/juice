import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 컵에 채워진 주스 수위를 웨이브 애니메이션으로 표현하는 게이지.
/// [remainingRatio]는 남은 예산 비율(0.0~1.0), [color]는 선택된 주스 테마의
/// 현재 단계 색상(호출부에서 [JuiceTheme.getColorByRatio]로 계산해 전달).
class JuiceGauge extends StatefulWidget {
  const JuiceGauge({
    super.key,
    required this.remainingRatio,
    required this.remaining,
    required this.total,
    required this.periodLabel,
    required this.color,
    this.isOverBudget = false,
  });

  final double remainingRatio;

  /// 목표 초과 시 음수가 될 수 있는 raw 잔여량(마이너스 표시/소진율 계산용).
  final double remaining;
  final double total;
  final Color color;
  final bool isOverBudget;

  /// "이번 주"/"오늘"/"이번 달"처럼 기준 기간을 가리키는 접두어.
  final String periodLabel;

  @override
  State<JuiceGauge> createState() => _JuiceGaugeState();
}

/// 목표 초과 시 상단에 무작위로 노출되는 위트 있는 멘트.
const _overBudgetMessages = [
  '아쉬워요! 다음 주엔 주스 남기기 꼭 성공해 봐요 🍊',
  '주스 통이 텅 비었어요! 이번 주는 잠시 쉬어가요 🥲',
  '넘친 주스는 어쩔 수 없죠! 다음 주에 다시 꽉 채워봐요 🧃',
  '마지막 한 방울까지 탈탈! 다음 주엔 조금만 천천히 마셔요 ✨',
];

class _JuiceGaugeState extends State<JuiceGauge> with TickerProviderStateMixin {
  late final AnimationController _waveController;
  late final AnimationController _levelController;
  late Animation<double> _levelAnimation;
  late final String _overBudgetMessage;

  @override
  void initState() {
    super.initState();
    _overBudgetMessage =
        _overBudgetMessages[Random().nextInt(_overBudgetMessages.length)];
    _waveController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
    _levelController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _levelAnimation = Tween<double>(begin: 0, end: widget.remainingRatio)
        .animate(CurvedAnimation(
            parent: _levelController, curve: Curves.easeOutCubic));
    _levelController.forward();
  }

  @override
  void didUpdateWidget(covariant JuiceGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remainingRatio != widget.remainingRatio) {
      _levelAnimation = Tween<double>(
              begin: _levelAnimation.value, end: widget.remainingRatio)
          .animate(CurvedAnimation(
              parent: _levelController, curve: Curves.easeOutCubic));
      _levelController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    _levelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color;
    final spentPercent = widget.total <= 0
        ? 0
        : (((widget.total - widget.remaining) / widget.total) * 100)
            .round()
            .clamp(0, 999);
    final formatter = NumberFormat('#,###');

    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: color.withValues(alpha: 0.35), width: 4),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: ClipOval(
              child: AnimatedBuilder(
                animation:
                    Listenable.merge([_waveController, _levelController]),
                builder: (context, _) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: _WavePainter(
                      level: _levelAnimation.value,
                      phase: _waveController.value * 2 * pi,
                      color: color,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '${widget.periodLabel} 남은 주스',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            '${formatter.format(widget.remaining)} / ${formatter.format(widget.total)} mL',
            textAlign: TextAlign.center,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '소진율 $spentPercent%',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        if (widget.isOverBudget) ...[
          const SizedBox(height: 10),
          Text(
            _overBudgetMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: widget.color, fontWeight: FontWeight.w600),
          ),
        ],
      ],
    );
  }
}

class _WavePainter extends CustomPainter {
  _WavePainter({required this.level, required this.phase, required this.color});

  final double level; // 0..1 채워진 높이 비율
  final double phase;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final clampedLevel = level.clamp(0.0, 1.0);
    final baseline = size.height * (1 - clampedLevel);
    const amplitude = 6.0;

    final backPaint = Paint()..color = color.withValues(alpha: 0.45);
    final backPath = Path()..moveTo(0, baseline + 5);
    for (double x = 0; x <= size.width; x += 4) {
      final y = baseline +
          5 +
          sin((x / size.width * 2 * pi) + phase + pi / 2) * (amplitude * 0.7);
      backPath.lineTo(x, y);
    }
    backPath
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(backPath, backPaint);

    final frontPaint = Paint()..color = color;
    final frontPath = Path()..moveTo(0, baseline);
    for (double x = 0; x <= size.width; x += 4) {
      final y = baseline + sin((x / size.width * 2 * pi) + phase) * amplitude;
      frontPath.lineTo(x, y);
    }
    frontPath
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(frontPath, frontPaint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) {
    return oldDelegate.level != level ||
        oldDelegate.phase != phase ||
        oldDelegate.color != color;
  }
}
