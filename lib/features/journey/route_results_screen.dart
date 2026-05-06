import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../models/route_option.dart';
import '../../widgets/app_card.dart';
import '../../widgets/mode_toggle.dart';
import '../../widgets/primary_button.dart';
import 'journey_provider.dart';

class RouteResultsScreen extends StatelessWidget {
  const RouteResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JourneyProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Route Results')),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
          children: [
            ModeToggle(
              value: provider.mode,
              onChanged: provider.setMode,
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Best routes to Chennai Airport',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    'AI ranked',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            ...provider.routes.map(
              (route) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: _RouteOptionCard(
                  route: route,
                  onSelect: () {
                    provider.selectRoute(route);
                    Navigator.pushNamed(context, AppRoutes.tripDetails);
                  },
                ),
              ),
            ),
            SizedBox(height: 2.h),
            const _MapPreview(),
          ],
        ),
      ),
    );
  }
}

class _RouteOptionCard extends StatelessWidget {
  const _RouteOptionCard({
    required this.route,
    required this.onSelect,
  });

  final RouteOption route;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            route.title,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                        if (route.isRecommended) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Text(
                              'Recommended',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '${route.duration} - ${route.arrival}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.muted,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              Text(
                'Rs. ${route.price}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              ...route.modes.map((icon) {
                return Container(
                  margin: EdgeInsets.only(right: 8.w),
                  height: 38.h,
                  width: 38.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.11),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20.sp),
                );
              }),
              const Spacer(),
              _MetricPill(icon: Icons.eco_rounded, label: '${route.carbonSaved} saved'),
              SizedBox(width: 8.w),
              _MetricPill(icon: Icons.shield_rounded, label: '${route.score}'),
            ],
          ),
          SizedBox(height: 16.h),
          PrimaryButton(label: 'Select Route', icon: Icons.arrow_forward_rounded, onPressed: onSelect),
        ],
      ),
    );
  }
}

class _MetricPill extends StatelessWidget {
  const _MetricPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15.sp, color: AppColors.success),
          SizedBox(width: 4.w),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}

class _MapPreview extends StatelessWidget {
  const _MapPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3F1),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _MapPainter()),
          ),
          Positioned(
            left: 16.w,
            top: 16.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(99),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16)],
              ),
              child: Row(
                children: [
                  const Icon(Icons.map_rounded, color: AppColors.primary, size: 18),
                  SizedBox(width: 6.w),
                  Text('Live map preview', style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    final routePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    for (var y = 30.0; y < size.height; y += 42) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y + 22), roadPaint);
    }
    for (var x = 22.0; x < size.width; x += 68) {
      canvas.drawLine(Offset(x, 0), Offset(x + 26, size.height), roadPaint);
    }

    final path = Path()
      ..moveTo(size.width * 0.14, size.height * 0.72)
      ..cubicTo(size.width * 0.32, size.height * 0.28, size.width * 0.55, size.height * 0.85, size.width * 0.84, size.height * 0.28);
    canvas.drawPath(path, routePaint);
    canvas.drawCircle(Offset(size.width * 0.14, size.height * 0.72), 8, Paint()..color = AppColors.success);
    canvas.drawCircle(Offset(size.width * 0.84, size.height * 0.28), 8, Paint()..color = AppColors.primary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
