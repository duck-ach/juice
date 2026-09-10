import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_root.dart';
import '../../core/widget/home_widget_launcher.dart';
import '../../core/widget/home_widget_sync.dart';
import '../../data/models/splash_flavor.dart';

/// 앱 시작 시 랜덤 주스 플레이버로 컵이 차오르는 스플래시 화면.
/// 연출이 끝나면 페이드 트랜지션으로 실제 앱 화면으로 전환된다.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final SplashFlavor _flavor;
  late final AnimationController _introController;
  late final AnimationController _waveController;
  late final Animation<double> _level;
  late final Animation<double> _contentFade;
  late final Animation<Offset> _contentSlide;

  static const _fillTargetLevel = 0.65;

  @override
  void initState() {
    super.initState();
    _flavor = splashFlavors[Random().nextInt(splashFlavors.length)];

    _introController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..forward();
    _waveController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();

    _level = Tween<double>(begin: 0, end: _fillTargetLevel).animate(
      CurvedAnimation(
          parent: _introController,
          curve: const Interval(0, 0.75, curve: Curves.easeOutCubic)),
    );
    _contentFade = CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.35, 1, curve: Curves.easeOut));
    _contentSlide =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _introController,
          curve: const Interval(0.35, 1, curve: Curves.easeOutCubic)),
    );

    Future.delayed(const Duration(milliseconds: 1700), _goToApp);
  }

  void _goToApp() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeWidgetSync(
          child: HomeWidgetLauncher(child: AppRoot()),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _introController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 140,
              height: 140,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: _flavor.primaryColor.withValues(alpha: 0.4),
                      width: 3),
                ),
                child: ClipOval(
                  child: AnimatedBuilder(
                    animation: Listenable.merge([_level, _waveController]),
                    builder: (context, _) {
                      return CustomPaint(
                        size: Size.infinite,
                        painter: _SplashWavePainter(
                          level: _level.value,
                          phase: _waveController.value * 2 * pi,
                          color: _flavor.primaryColor,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            FadeTransition(
              opacity: _contentFade,
              child: SlideTransition(
                position: _contentSlide,
                child: Column(
                  children: [
                    Text(_flavor.fruitEmoji,
                        style: const TextStyle(fontSize: 26)),
                    const SizedBox(height: 6),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'JUIC',
                            style: GoogleFonts.fredoka(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                          TextSpan(
                            text: 'E',
                            style: GoogleFonts.fredoka(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: _flavor.primaryColor,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _flavor.subText,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF9A9A9A)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashWavePainter extends CustomPainter {
  _SplashWavePainter(
      {required this.level, required this.phase, required this.color});

  final double level;
  final double phase;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final clampedLevel = level.clamp(0.0, 1.0);
    final baseline = size.height * (1 - clampedLevel);
    const amplitude = 5.0;
    const overflow = 4.0;
    final backPaint = Paint()..color = color.withValues(alpha: 0.45);
    final backPath = Path()..moveTo(-overflow, baseline + 4);
    for (double x = -overflow; x <= size.width + overflow; x += 2) {
      final y = baseline +
          4 +
          sin((x / size.width * 2 * pi) + phase + pi / 2) * (amplitude * 0.7);
      backPath.lineTo(x, y);
    }
    backPath
      ..lineTo(size.width + overflow, size.height + overflow)
      ..lineTo(-overflow, size.height + overflow)
      ..close();
    canvas.drawPath(backPath, backPaint);

    final frontPaint = Paint()..color = color;
    final frontPath = Path()..moveTo(-overflow, baseline);
    for (double x = -overflow; x <= size.width + overflow; x += 2) {
      final y = baseline + sin((x / size.width * 2 * pi) + phase) * amplitude;
      frontPath.lineTo(x, y);
    }
    frontPath
      ..lineTo(size.width + overflow, size.height + overflow)
      ..lineTo(-overflow, size.height + overflow)
      ..close();
    canvas.drawPath(frontPath, frontPaint);
  }

  @override
  bool shouldRepaint(covariant _SplashWavePainter oldDelegate) {
    return oldDelegate.level != level ||
        oldDelegate.phase != phase ||
        oldDelegate.color != color;
  }
}
