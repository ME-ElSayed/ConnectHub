import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedCardContent extends StatelessWidget {
  const FeedCardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "title",
          style: AppStyles.title20SemiBold.copyWith(
            fontSize: 21.sp,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          "content",
          style: AppStyles.body16Regular.copyWith(
            height: 1.4,
          ),
        ),
      ],
    );
  }
}