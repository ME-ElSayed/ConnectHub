import 'package:connect_hub/features/profile/presentation/widgets/profile_header.dart';
import 'package:connect_hub/features/profile/presentation/widgets/profile_posts_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ProfileHeader(
                name: "sia",
                imageUrl:
                    "https://i.ibb.co/SXrF9sL1/image-cropper-1785691682814.jpg",
                isLoggingOut: true,
                onLogout: () {},
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 16.h)),
            ProfilePostsGrid(),
          ],
        ),
      ),
    );
  }
}
