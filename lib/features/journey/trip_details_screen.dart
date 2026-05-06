import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../models/route_option.dart';
import '../../widgets/app_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/soft_icon.dart';
import 'journey_provider.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final route = context.watch<JourneyProvider>().selectedRoute ?? context.watch<JourneyProvider>().routes.first;

    return Scaffold(
      appBar: AppBar(title: const Text('Trip Details')),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
          children: [
            _RouteMap(route: route),
            SizedBox(height: 18.h),
            Text('Journey Breakdown', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
            SizedBox(height: 12.h),
            ..._stepsFor(route).asMap().entries.map(
                  (entry) => _StepTile(index: entry.key + 1, text: entry.value),
                ),
            SizedBox(height: 18.h),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price Breakdown', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
                  SizedBox(height: 12.h),
                  _PriceRow(label: 'Base fare', value: 'Rs. ${route.price - 12}'),
                  _PriceRow(label: 'Platform safety fee', value: 'Rs. 8'),
                  _PriceRow(label: 'GST', value: 'Rs. 4'),
                  const Divider(height: 24),
                  _PriceRow(label: 'Total prepaid', value: 'Rs. ${route.price}', strong: true),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: AppCard(
                    child: _ScoreTile(
                      icon: Icons.shield_rounded,
                      label: 'Safety Score',
                      value: '${route.score}/100',
                      color: AppColors.success,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: AppCard(
                    child: _ScoreTile(
                      icon: Icons.eco_rounded,
                      label: 'Carbon Points',
                      value: '+${route.price ~/ 2}',
                      color: AppColors.teal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            PrimaryButton(
              label: 'Confirm & Pay',
              icon: Icons.lock_rounded,
              onPressed: () => Navigator.pushNamed(context, AppRoutes.payment),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _stepsFor(RouteOption route) {
    if (route.modes.length == 1) {
      return [
        'Pickup from Current Location in 4 min',
        'Ride directly toward Chennai Airport',
        'Arrive at prepaid drop zone with QR receipt',
      ];
    }
    return [
      'Walk 250 m to T Nagar Metro Gate 2',
      'Board Blue Line toward Airport Terminal',
      'Switch to prepaid auto for last-mile drop',
      'Scan QR ticket at destination checkpoint',
    ];
  }
}

class _RouteMap extends StatelessWidget {
  const _RouteMap({required this.route});

  final RouteOption route;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210.h,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.textDark,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                route.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const Spacer(),
              Text(
                'Rs. ${route.price}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Expanded(
            child: CustomPaint(
              painter: _TripMapPainter(),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({required this.index, required this.text});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: AppCard(
        padding: EdgeInsets.all(14.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16.r,
              backgroundColor: AppColors.primary,
              child: Text('$index', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.value, this.strong = false});

  final String label;
  final String value;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: strong ? FontWeight.w900 : FontWeight.w600,
          color: strong ? AppColors.textDark : AppColors.muted,
        );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style?.copyWith(color: strong ? AppColors.primary : AppColors.textDark)),
        ],
      ),
    );
  }
}

class _ScoreTile extends StatelessWidget {
  const _ScoreTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SoftIcon(icon: icon, color: color),
        SizedBox(height: 12.h),
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.muted)),
        Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
      ],
    );
  }
}

class _TripMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(size.width * 0.08, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.34, size.height * 0.2, size.width * 0.55, size.height * 0.52)
      ..quadraticBezierTo(size.width * 0.74, size.height * 0.82, size.width * 0.93, size.height * 0.24);
    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset(size.width * 0.08, size.height * 0.7), 9, Paint()..color = AppColors.success);
    canvas.drawCircle(Offset(size.width * 0.93, size.height * 0.24), 9, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
