import 'package:connect_hub/features/profile/data/models/profile_post.dart';
import 'package:connect_hub/features/profile/presentation/widgets/profile_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePostsGrid extends StatelessWidget {
  const ProfilePostsGrid({super.key, this.posts = const <ProfilePost>[]});

  final List<ProfilePost> posts;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return ProfilePostCard(post: posts[index]);
      }, childCount: posts.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        mainAxisExtent: 205.h,
      ),
    );
  }
}
