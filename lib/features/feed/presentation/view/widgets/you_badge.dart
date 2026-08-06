import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YouBadge extends StatelessWidget {
  const YouBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryOverlay10,
        borderRadius:
            BorderRadius.circular(8.r),
      ),
      child: Text(
        'You',
        style:
            AppStyles.label14PrimarySemiBold,
      ),
    );
  }
}