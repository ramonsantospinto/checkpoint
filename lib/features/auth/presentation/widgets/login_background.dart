import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;
  const LoginBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0F),
      body: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(child: CustomPaint(painter: _GlowPainter())),
          ),
          child,
        ],
      ),
    );
  }
}

class _GlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Paint()
      ..shader =
          RadialGradient(
            colors: [Colors.white.withValues(alpha: 0.09), Colors.transparent],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.20, size.height * 0.22),
              radius: size.shortestSide * 0.65,
            ),
          );

    final p2 = Paint()
      ..shader =
          RadialGradient(
            colors: [Colors.white.withValues(alpha: 0.06), Colors.transparent],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.88, size.height * 0.70),
              radius: size.shortestSide * 0.80,
            ),
          );

    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF0B0B0F),
    );
    canvas.drawCircle(
      Offset(size.width * 0.20, size.height * 0.22),
      size.shortestSide * 0.65,
      p1,
    );
    canvas.drawCircle(
      Offset(size.width * 0.88, size.height * 0.70),
      size.shortestSide * 0.80,
      p2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
