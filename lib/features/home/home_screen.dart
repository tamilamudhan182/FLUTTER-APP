import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../features/journey/journey_provider.dart';
import '../../models/journey_mode.dart';
import '../../widgets/app_card.dart';
import '../../widgets/mode_toggle.dart';
import '../../widgets/soft_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JourneyProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning, Traveler',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Chennai mobility is live and ready.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.muted,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundColor: Color(0xFFFFE9DB),
                    child: Icon(Icons.person_rounded, color: AppColors.primary),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              AppCard(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                onTap: () => Navigator.pushNamed(context, AppRoutes.search),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded, color: AppColors.primary),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Where would you like to go today?',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.muted,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
              ModeToggle(
                value: provider.mode,
                onChanged: provider.setMode,
              ),
              SizedBox(height: 20.h),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 14.w,
                mainAxisSpacing: 14.h,
                childAspectRatio: 1.2,
                children: [
                  _QuickAction(title: 'Book Auto', icon: Icons.electric_rickshaw_rounded, color: AppColors.primary),
                  _QuickAction(title: 'Metro Pass', icon: Icons.train_rounded, color: AppColors.blue),
                  _QuickAction(title: 'Safe Cab', icon: Icons.local_taxi_rounded, color: AppColors.success),
                  _QuickAction(title: 'Bike Ride', icon: Icons.two_wheeler_rounded, color: AppColors.purple),
                ],
              ),
              SizedBox(height: 20.h),
              AppCard(
                child: Row(
                  children: [
                    const SoftIcon(icon: Icons.eco_rounded, color: AppColors.success),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Carbon Savings',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '18.4 kg CO₂ saved this month',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.muted,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        '+420 pts',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              _LiveRecommendation(mode: provider.mode),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SoftIcon(icon: icon, color: color),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
        ],
      ),
    );
  }
}

class _LiveRecommendation extends StatelessWidget {
  const _LiveRecommendation({required this.mode});

  final JourneyMode mode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.textDark,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          const SoftIcon(icon: Icons.auto_awesome_rounded, color: AppColors.amber),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mode == JourneyMode.combined ? 'AI suggests Metro + Auto' : 'AI suggests prepaid cab',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Balanced for time, price, safety, and emissions.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
