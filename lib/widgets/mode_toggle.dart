import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';
import '../models/journey_mode.dart';

class ModeToggle extends StatelessWidget {
  const ModeToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final JourneyMode value;
  final ValueChanged<JourneyMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE9DB),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: JourneyMode.values.map((mode) {
          final active = value == mode;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(mode),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: active ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(13.r),
                ),
                child: Text(
                  mode == JourneyMode.direct ? 'Direct Mode' : 'Combined Mode',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: active ? Colors.white : AppColors.primaryDark,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
