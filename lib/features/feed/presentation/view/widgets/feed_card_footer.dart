import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedCardFooter extends StatelessWidget {
  const FeedCardFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.favorite_border_rounded,
          size: 22.sp,
          color: AppColors.textSecondary,
        ),
        SizedBox(width: 6.w),
        Text(
          '25',
          style: AppStyles.body14SecondaryRegular,
        ),
        SizedBox(width: 16.w),
        Icon(
          Icons.mode_comment_outlined,
          size: 22.sp,
          color: AppColors.textSecondary,
        ),
        SizedBox(width: 6.w),
        Text(
          '20',
          style: AppStyles.body14SecondaryRegular,
        ),
        const Spacer(),
        Text(
          "time",
          style: AppStyles.body14SecondaryRegular,
        ),
      ],
    );
  }
}