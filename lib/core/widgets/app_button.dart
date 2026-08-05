import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
    this.borderRadius = 12,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = AppColors.textOnPrimary,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
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
        width: width ?? double.infinity,
        height: height ?? 56.h,
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
          child: isLoading
              ? SizedBox(
                  width: 25.r,
                  height: 25.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: foregroundColor,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 14.h, bottom: 14.h),
                  child: Text(text, style: AppStyles.label14OnPrimarySemiBold),
                ),
        ),
      ),
    );
  }
}
