import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/profile_pic.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/you_badge.dart';
import 'package:connect_hub/features/post/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedCardHeader extends StatelessWidget {
  const FeedCardHeader({
    super.key,
    required this.post,
    required this.isCurrentUserPost,
  });

  final PostModel post;
  final bool isCurrentUserPost;

  @override
  Widget build(BuildContext context) {
    final displayName = _displayName(post);
    final username = _username(post);

    return Row(
      children: [
        ProfilePic(
          size: 50.r,
          imageUrl: post.ownerProfileImageUrl,
        ),

        SizedBox(width: 12.w),

        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.title16SemiBold,
                    ),
                    Text(
                      username,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          AppStyles.body14SecondaryRegular,
                    ),
                  ],
                ),
              ),

              if (isCurrentUserPost)
                const YouBadge(),
            ],
          ),
        ),
      ],
    );
  }

  String _displayName(PostModel post) {
    final displayName =
        post.ownerDisplayName.trim();

    if (displayName.isNotEmpty) {
      return displayName;
    }

    final username =
        post.ownerUsername.trim();

    if (username.isNotEmpty) {
      return username;
    }

    return 'ConnectHub user';
  }

  String _username(PostModel post) {
    final username =
        post.ownerUsername.trim();

    if (username.isEmpty) {
      return 'ConnectHub';
    }

    return username.startsWith('@')
        ? username
        : '@$username';
  }
}