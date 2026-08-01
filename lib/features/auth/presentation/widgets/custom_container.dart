import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 15.r,
            spreadRadius: -3.r,
            offset: Offset(0, 10.h),
          ),
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6.r,
            spreadRadius: -4.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: child,
      );
  }
}