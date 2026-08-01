import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/theme/app_colors.dart';

class SplashAppLogo extends StatelessWidget {
  const SplashAppLogo({super.key, this.size = 96, this.iconSize = 48});

  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        color: AppColors.whiteOverlay95,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowStrong,
            blurRadius: 50.r,
            spreadRadius: -12.r,
            offset: Offset(0, 25.h),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        AppAssets.connectHubLogo,
        width: iconSize.r,
        height: iconSize.r,
        fit: BoxFit.fill,
      ),
    );
  }
}
