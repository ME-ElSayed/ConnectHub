import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedCardContent extends StatelessWidget {
  const FeedCardContent({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        AppStyles.title20SemiBold.copyWith(
      fontSize: 21.sp,
    );

    final contentStyle =
        AppStyles.body16Regular.copyWith(
      height: 1.4,
    );

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: titleStyle,
        ),
        SizedBox(height: 6.h),
        Text(
          content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: contentStyle,
        ),
      ],
    );
  }
}