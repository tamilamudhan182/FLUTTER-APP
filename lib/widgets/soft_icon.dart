import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';

class SoftIcon extends StatelessWidget {
  const SoftIcon({
    super.key,
    required this.icon,
    this.color = AppColors.primary,
    this.size = 44,
  });

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.h,
      width: size.h,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Icon(icon, color: color, size: (size * 0.52).sp),
    );
  }
}
