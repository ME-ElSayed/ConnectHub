import 'package:connect_hub/core/di/service_locator.dart';
import 'package:connect_hub/core/services/firestore_service.dart';
import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/core/utils/hide_nav_bar.dart';
import 'package:connect_hub/core/widgets/hide_naviagtion.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/custom_app_bar.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_card.dart';
import 'package:connect_hub/features/post/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeFeedView extends StatelessWidget {
  final HideNavbar controller;
  const HomeFeedView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HideNavigation(
        hidecontroller: controller,
        child: StreamBuilder<List<PostModel>>(
          stream: getIt<FirestoreService>().watchPosts(),
          builder: (context, snapshot) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColors.white,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  pinned: false,
                  floating: true,
                  snap: true,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 92.h,
                  titleSpacing: 0,
                  title: const SafeArea(bottom: false, child: CustomAppBar()),
                ),
                _buildPostsSliver(snapshot),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPostsSliver(AsyncSnapshot<List<PostModel>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting &&
        !snapshot.hasData) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (snapshot.hasError && !snapshot.hasData) {
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

    final posts = snapshot.data ?? const <PostModel>[];

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
