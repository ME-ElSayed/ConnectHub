import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedAppBar extends StatelessWidget {
  const FeedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      floating: true,
      snap: true,
      pinned: false,
      automaticallyImplyLeading: false,
      toolbarHeight: 92.h,
      titleSpacing: 0,
      title: const SafeArea(
        bottom: false,
        child: CustomAppBar(),
      ),
    );
  }
}