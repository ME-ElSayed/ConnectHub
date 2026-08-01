import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 48,
    this.borderRadius = 12,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = AppColors.textOnPrimary,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: AppColors.primaryOverlay25,
                  blurRadius: 15.r,
                  spreadRadius: -3.r,
                  offset: Offset(0, 10.h),
                ),
                BoxShadow(
                  color: AppColors.primaryOverlay25,
                  blurRadius: 6.r,
                  spreadRadius: -4.r,
                  offset: Offset(0, 4.h),
                ),
              ]
            : null,
      ),
      child: SizedBox(
        width: double.infinity,
        height: height.h,
        child: FilledButton(
          onPressed: isEnabled ? onPressed : null,
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            disabledBackgroundColor: AppColors.neutral100,
            disabledForegroundColor: AppColors.textSecondary,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
            ),
            textStyle: AppStyles.label14SemiBold,
          ),
          child: isLoading
              ? SizedBox(
                  width: 18.r,
                  height: 18.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: foregroundColor,
                  ),
                )
              : Text(text),
        ),
      ),
    );
  }
}
