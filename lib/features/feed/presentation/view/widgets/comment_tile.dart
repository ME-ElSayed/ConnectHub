import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/core/utils/time_ago.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/profile_pic.dart';
import 'package:connect_hub/features/post/data/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({
    super.key,
    required this.comment,
  });

  final CommentModel comment;

  String get _username {
    final username = comment.username.trim();

    if (username.isEmpty) {
      return 'Unknown user';
    }

    return username;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePic(
          imageUrl: comment.profileImageUrl,
          size: 38.r,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _username,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style:
                          AppStyles.label14SemiBold,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    timeAgo(comment.createdAt),
                    style: AppStyles
                        .body12SecondaryRegular,
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Text(
                comment.message,
                style: AppStyles.body14Regular
                    .copyWith(height: 1.35),
              ),
            ],
          ),
        ),
      ],
    );
  }
}