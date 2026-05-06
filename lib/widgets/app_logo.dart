import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';

class AppLogo extends StatefulWidget {
  const AppLogo({
    super.key,
    this.size = 96,
    this.animate = false,
  });

  final double size;
  final bool animate;

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant AppLogo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          size: Size.square(widget.size.w),
          painter: _LogoPainter(progress: widget.animate ? _controller.value : 1),
        );
      },
    );
  }
}

class _LogoPainter extends CustomPainter {
  _LogoPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width * 0.39;
    final stroke = size.width * 0.13;

    final oPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, oPaint);

    final pathBasePaint = Paint()
      ..color = Colors.white.withOpacity(0.48)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.045
      ..strokeCap = StrokeCap.round;
    final pathPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.047
      ..strokeCap = StrokeCap.round;

    final route = Path()
      ..moveTo(center.dx - radius * 0.55, center.dy + radius * 0.18)
      ..quadraticBezierTo(center.dx - radius * 0.2, center.dy - radius * 0.42, center.dx + radius * 0.08, center.dy)
      ..quadraticBezierTo(center.dx + radius * 0.34, center.dy + radius * 0.42, center.dx + radius * 0.58, center.dy - radius * 0.22);
    canvas.drawPath(route, pathBasePaint);
    final metric = route.computeMetrics().first;
    final visibleLength = metric.length * progress.clamp(0.08, 1).toDouble();
    canvas.drawPath(metric.extractPath(0, visibleLength), pathPaint);

    final angle = progress * math.pi * 2;
    final dot = Offset(
      center.dx + math.cos(angle) * radius * 0.58,
      center.dy + math.sin(angle) * radius * 0.58,
    );
    canvas.drawCircle(dot, size.width * 0.052, Paint()..color = AppColors.textDark);
  }

  @override
  bool shouldRepaint(covariant _LogoPainter oldDelegate) => oldDelegate.progress != progress;
}
