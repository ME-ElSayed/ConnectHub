import 'package:connect_hub/core/di/service_locator.dart';
import 'package:connect_hub/core/services/auth_service.dart';
import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_card_content.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_card_footer.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_card_header.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_card_image.dart';
import 'package:connect_hub/features/post/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedCard extends StatelessWidget {
  FeedCard({
    super.key,
    required this.post,
  });

  final PostModel post;

  static final AuthService _auth = getIt<AuthService>();

  @override
  Widget build(BuildContext context) {
    final hasImage = post.imageUrl.trim().isNotEmpty;

    return Container(
      padding: EdgeInsets.fromLTRB(
        18.w,
        12.h,
        18.w,
        12.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FeedCardHeader(
            post: post,
            isCurrentUserPost:
                _auth.currentUser?.uid == post.ownerId,
          ),

          SizedBox(height: 12.h),

          FeedCardContent(
            title: post.title,
            content: post.content,
          ),

          if (hasImage) ...[
            SizedBox(height: 14.h),
            FeedCardImage(
              imageUrl: post.imageUrl,
            ),
          ],

          SizedBox(height: 12.h),

          FeedCardFooter(
            post: post,
          ),
        ],
      ),
    );
  }
}