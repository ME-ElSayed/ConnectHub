import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/footer_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentButton extends StatelessWidget {
  const CommentButton({
    super.key,
    required this.commentsCount,
    this.onTap,
  });

  final int commentsCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FooterTap(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.mode_comment_outlined,
            size: 22.sp,
            color: AppColors.textSecondary,
          ),
          SizedBox(width: 6.w),
          Text(
            '$commentsCount',
            style: AppStyles.body14SecondaryRegular,
          ),
        ],
      ),
    );
  }
}