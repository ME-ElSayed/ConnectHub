import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/footer_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    super.key,
    required this.isLiked,
    required this.likesCount,
    this.onLike,
    this.onCountTap,
  });

  final bool isLiked;
  final int likesCount;
  final VoidCallback? onLike;
  final VoidCallback? onCountTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FooterTap(
          onTap: onLike,
          child: Icon(
            isLiked
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            size: 22.sp,
            color: isLiked
                ? Colors.redAccent
                : AppColors.textSecondary,
          ),
        ),
        SizedBox(width: 6.w),
        FooterTap(
          onTap: onCountTap,
          child: Text(
            '$likesCount',
            style: AppStyles.body14SecondaryRegular,
          ),
        ),
      ],
    );
  }
}