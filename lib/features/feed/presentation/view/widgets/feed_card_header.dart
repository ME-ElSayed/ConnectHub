import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedCardHeader extends StatelessWidget {
  const FeedCardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfilePic(
          size: 50.r,
          imageUrl:
              "https://i.ibb.co/SXrF9sL1/image-cropper-1785691682814.jpg",
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "name",
                      style: AppStyles.title16SemiBold,
                    ),
                    Text(
                      "email",
                      style: AppStyles.body14SecondaryRegular,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryOverlay10,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'You',
                  style: AppStyles.label14PrimarySemiBold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}