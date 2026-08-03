import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_card_content.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_card_footer.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_card_header.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_card_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedCard extends StatelessWidget {
  const FeedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FeedCardHeader(),
          SizedBox(height: 12.h),
          const FeedCardContent(),
          SizedBox(height: 14.h),
          const FeedCardImage(),
          SizedBox(height: 12.h),
          const FeedCardFooter(),
        ],
      ),
    );
  }
}