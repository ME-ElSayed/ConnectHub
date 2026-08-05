import 'package:connect_hub/features/profile/data/models/profile_post.dart';
import 'package:connect_hub/features/profile/presentation/widgets/profile_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePostsGrid extends StatelessWidget {
  const ProfilePostsGrid({super.key});

  static const List<ProfilePost> _posts = [
    ProfilePost(
      title: 'Alps weekend\nescape',
      likes: '248',
      imageLink: "https://i.ibb.co/SXrF9sL1/image-cropper-1785691682814.jpg",
    ),
    ProfilePost(
      title: 'My morning ritual ☕',
      likes: '176',
      imageLink: "https://i.ibb.co/SXrF9sL1/image-cropper-1785691682814.jpg",
    ),
    ProfilePost(
      title: 'Golden hour\ndowntown',
      likes: '402',
      imageLink:"https://i.ibb.co/SXrF9sL1/image-cropper-1785691682814.jpg",
    ),
    ProfilePost(
      title: 'Lunch goals 🥗',
      likes: '91',
      imageLink: "https://i.ibb.co/SXrF9sL1/image-cropper-1785691682814.jpg",
    ),
    ProfilePost(
      title: 'New workspace\nvibes',
      likes: '63',
      imageLink: "https://i.ibb.co/SXrF9sL1/image-cropper-1785691682814.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return ProfilePostCard(post: _posts[index]);
      }, childCount: _posts.length ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        mainAxisExtent: 205.h,
      ),
    );
  }
}
