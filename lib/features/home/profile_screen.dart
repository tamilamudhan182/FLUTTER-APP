import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../features/journey/journey_provider.dart';
import '../../widgets/app_card.dart';
import '../../widgets/soft_icon.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final language = context.watch<JourneyProvider>().language;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            AppCard(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFFFE9DB),
                    child: Icon(Icons.person_rounded, color: AppColors.primary),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Traveler', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
                        Text('+91 98765 43210', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.muted)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            AppCard(
              child: Row(
                children: [
                  const SoftIcon(icon: Icons.translate_rounded, color: AppColors.purple),
                  SizedBox(width: 14.w),
                  Expanded(child: Text('Language: $language', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
