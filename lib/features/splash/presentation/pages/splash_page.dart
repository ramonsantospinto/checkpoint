import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2700),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.00, 0.28, curve: Curves.easeOutCubic),
    );

    _scale = Tween<double>(begin: 0.78, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.05, 0.55, curve: Curves.easeOutBack),
      ),
    );

    _glow = Tween<double>(begin: 0.0, end: 18.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!mounted) return;
        context.pushReplacement('/login');
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _easeInOut(double t) => Curves.easeInOutCubic.transform(t);
  double _lerp(double a, double b, double t) => a + (b - a) * t;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          final h = c.maxHeight;

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = _controller.value;

              const split = 0.68;
              final startX = -w * 0.50;
              final endX = w * 0.50;

              double dx;
              if (t <= split) {
                final p = _easeInOut(t / split);
                dx = _lerp(startX, endX, p);
              } else {
                final p = _easeInOut((t - split) / (1 - split));
                dx = _lerp(endX, 0.0, p);
              }

              final baseY = 0.06 * h;
              final waveAmp = 0.10 * h;
              final wave = math.sin(t * math.pi) * waveAmp;
              final dy = baseY - wave;

              return Center(
                child: FadeTransition(
                  opacity: _fade,
                  child: Transform.translate(
                    offset: Offset(dx, dy),
                    child: ScaleTransition(
                      scale: _scale,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.10),
                              blurRadius: _glow.value,
                              spreadRadius: (_glow.value / 5).clamp(0, 5),
                            ),
                          ],
                        ),
                        child: Hero(
                          tag: 'cp-logo',
                          child: Image.asset(
                            'assets/images/mobile_game.png',
                            width: 132,
                            height: 132,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                            color: Colors.white.withValues(alpha: 0.92),
                            colorBlendMode: BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
