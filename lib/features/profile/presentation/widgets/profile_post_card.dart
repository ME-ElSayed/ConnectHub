import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/core/widgets/app_cached_image.dart';
import 'package:connect_hub/features/profile/data/models/profile_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePostCard extends StatelessWidget {
  const ProfilePostCard({super.key, required this.post});

  final ProfilePost post;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 6.r,
            spreadRadius: -1.r,
            offset: Offset(0, 4.h),
          ),
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4.r,
            spreadRadius: -2.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 112.h,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedImage(imageUrl: post.imageLink),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [AppColors.imageScrim, AppColors.transparent],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.label14SemiBold.copyWith(
                        height: 17.5 / 14,
                      ),
                    ),
                    const Spacer(),
                    _PostLikes(likes: post.likes),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostLikes extends StatelessWidget {
  const _PostLikes({required this.likes});

  final String likes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.favorite_border, color: AppColors.textSecondary, size: 24.r),
        SizedBox(width: 4.w),
        Text(likes, style: AppStyles.body12SecondaryRegular),
      ],
    );
  }
}
