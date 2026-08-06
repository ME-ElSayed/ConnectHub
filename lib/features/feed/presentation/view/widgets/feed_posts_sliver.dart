import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_card.dart';
import 'package:connect_hub/features/post/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'dummy_posts.dart';

class FeedPostsSliver extends StatelessWidget {
  const FeedPostsSliver({super.key, required this.snapshot});

  final AsyncSnapshot<List<PostModel>> snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasError) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Could not load posts.',
              textAlign: TextAlign.center,
              style: AppStyles.body14SecondaryRegular,
            ),
          ),
        ),
      );
    }

    if (!snapshot.hasData) {
      return SliverPadding(
        padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 10.h),
        sliver: SliverSkeletonizer(
          enabled: true,
          child: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 14.h),
                child: FeedCard(post: skeletonPosts[index]),
              ),
              childCount: skeletonPosts.length,
            ),
          ),
        ),
      );
    }

    final posts = snapshot.data!;

    if (posts.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text('No posts yet.', style: AppStyles.body14SecondaryRegular),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 10.h),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: FeedCard(post: posts[index]),
          ),
          childCount: posts.length,
        ),
      ),
    );
  }
}
