import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/app_card.dart';
import '../../widgets/soft_icon.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trips')),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _TripTile(title: 'T Nagar to Airport', subtitle: 'Metro + Auto - Completed', amount: 'Rs. 74'),
          SizedBox(height: 14.h),
          _TripTile(title: 'Anna Nagar to OMR', subtitle: 'Safe Cab - Completed', amount: 'Rs. 326'),
        ],
      ),
    );
  }
}

class _TripTile extends StatelessWidget {
  const _TripTile({required this.title, required this.subtitle, required this.amount});

  final String title;
  final String subtitle;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          const SoftIcon(icon: Icons.route_rounded, color: AppColors.blue),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900)),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.muted)),
              ],
            ),
          ),
          Text(amount, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
