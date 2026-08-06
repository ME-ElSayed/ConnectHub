import 'package:connect_hub/core/di/service_locator.dart';
import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/profile_pic.dart';
import 'package:connect_hub/features/feed/presentation/cubits/likes_state.dart';
import 'package:connect_hub/features/feed/presentation/cubits/likes_cubit.dart';
import 'package:connect_hub/features/post/data/models/like_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showLikesBottomSheet({
  required BuildContext context,
  required String postId,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (_) {
      return BlocProvider(
        create: (_) => getIt<LikesViewModel>()..watchLikes(postId),
        child: const _LikesBottomSheetContent(),
      );
    },
  );
}

class _LikesBottomSheetContent extends StatelessWidget {
  const _LikesBottomSheetContent();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.45,
      minChildSize: 0.25,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: AppColors.neutral200,
                      borderRadius: BorderRadius.circular(99.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text('Likes', style: AppStyles.title18SemiBold),
                SizedBox(height: 12.h),
                Expanded(
                  child: BlocBuilder<LikesViewModel, LikesState>(
                    builder: (context, state) {
                      if (state.status == LikesStatus.loading &&
                          state.likes.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.status == LikesStatus.error &&
                          state.likes.isEmpty) {
                        return Center(
                          child: Text(
                            state.errorMessage ?? 'Could not load likes.',
                            textAlign: TextAlign.center,
                            style: AppStyles.body14SecondaryRegular,
                          ),
                        );
                      }

                      if (state.likes.isEmpty) {
                        return Center(
                          child: Text(
                            'No likes yet',
                            style: AppStyles.body14SecondaryRegular,
                          ),
                        );
                      }

                      return ListView.separated(
                        controller: scrollController,
                        itemCount: state.likes.length,
                        separatorBuilder: (_, _) => SizedBox(height: 10.h),
                        itemBuilder: (context, index) {
                          return _LikeUserTile(like: state.likes[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LikeUserTile extends StatelessWidget {
  const _LikeUserTile({required this.like});

  final LikeModel like;

  @override
  Widget build(BuildContext context) {
    final username = like.username.trim().isEmpty
        ? 'Unknown user'
        : like.username.trim();

    return Row(
      children: [
        ProfilePic(imageUrl: like.profileImageUrl, size: 42.r),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            username,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.title16SemiBold,
          ),
        ),
      ],
    );
  }
}
