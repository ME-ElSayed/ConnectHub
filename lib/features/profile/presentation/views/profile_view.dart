import 'package:connect_hub/core/di/service_locator.dart';
import 'package:connect_hub/core/routing/routes.dart';
import 'package:connect_hub/core/utils/show_message.dart';
import 'package:connect_hub/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:connect_hub/features/profile/data/models/profile_post.dart';
import 'package:connect_hub/features/profile/presentation/cubits/profile_cubit/profile_state.dart';
import 'package:connect_hub/features/profile/presentation/widgets/profile_header.dart';
import 'package:connect_hub/features/profile/presentation/widgets/profile_posts_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state.status == ProfileStatus.logoutSuccess) {
                  context.go(Routes.login);
                } else if (state.status == ProfileStatus.failure &&
                    state.errorMessage != null) {
                  showMessage(
                    context,
                    'Profile Error',
                    state.errorMessage!,
                    Colors.red,
                    Colors.white,
                  );
                }
              },
              builder: (context, state) {
                if (state.isLoading && state.user == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                final posts = state.posts
                    .map(
                      (post) => ProfilePost(
                        title: post.title,
                        likes: post.likesCount.toString(),
                        imageLink: post.imageUrl.isNotEmpty
                            ? post.imageUrl
                            : 'https://i.ibb.co/SXrF9sL1/image-cropper-1785691682814.jpg',
                      ),
                    )
                    .toList();

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsetsGeometry.only(top: 68.h),
                        child: ProfileHeader(
                          name: state.user?.name ?? 'User',
                          email: state.user?.email ?? '',
                          imageUrl: state.user?.photoUrl,
                          isLoggingOut: state.isLoggingOut,
                          onLogout: state.isLoggingOut
                              ? null
                              : () => context.read<ProfileCubit>().logout(),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                    if (posts.isEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Center(
                            child: Text(
                              'No posts yet.',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      ProfilePostsGrid(posts: posts),
                    SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
