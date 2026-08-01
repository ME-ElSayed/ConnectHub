import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/theme/app_colors.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key, this.size = 64, this.iconSize = 32});

  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
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
        ],
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        AppAssets.authLogo,
        width: iconSize.r,
        height: iconSize.r,
        fit: BoxFit.fill,
      ),
    );
  }
}
