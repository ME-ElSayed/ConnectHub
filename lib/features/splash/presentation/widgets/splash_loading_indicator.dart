import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import 'splash_loading_dots.dart';

class SplashLoadingIndicator extends StatelessWidget {
  const SplashLoadingIndicator({
    super.key,
    this.message = 'Loading your world\u2026',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SplashLoadingDots(),
        SizedBox(height: 16.h),
        Text(
          message,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppStyles.body12Regular.copyWith(
            color: AppColors.whiteOverlay60,
          ),
        ),
      ],
    );
  }
}
