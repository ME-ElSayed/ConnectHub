import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/utils/hide_nav_bar.dart';
import 'package:connect_hub/core/widgets/hide_naviagtion.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/custom_app_bar.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_card.dart';
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
        child: CustomScrollView(
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

            SliverPadding(
              padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 10.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 14.h),
                    child: const FeedCard(),
                  ),
                  childCount: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
