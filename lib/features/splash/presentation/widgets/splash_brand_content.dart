import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import 'splash_app_logo.dart';

class SplashBrandContent extends StatelessWidget {
  const SplashBrandContent({
    super.key,
    this.title = 'ConnectHub',
    this.subtitle = 'Share, Connect, and Discover.',
    this.logo = const SplashAppLogo(),
  });

  final String title;
  final String subtitle;
  final Widget logo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        logo,
        SizedBox(height: 24.h),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppStyles.display36WhiteRegular,
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppStyles.body16Regular.copyWith(
            color: AppColors.whiteOverlay80,
          ),
        ),
      ],
    );
  }
}
