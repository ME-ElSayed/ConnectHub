import 'package:connect_hub/core/di/service_locator.dart';
import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/core/utils/time_ago.dart';
import 'package:connect_hub/features/feed/presentation/view/comment_screen.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/likes_bottom_sheet.dart';
import 'package:connect_hub/features/feed/presentation/cubits/like_state.dart';
import 'package:connect_hub/features/feed/presentation/cubits/like_cubit.dart';
import 'package:connect_hub/features/post/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedCardFooter extends StatefulWidget {
  const FeedCardFooter({super.key, required this.post});

  final PostModel post;

  @override
  State<FeedCardFooter> createState() => _FeedCardFooterState();
}

class _FeedCardFooterState extends State<FeedCardFooter> {
  late final LikeCubit _likeViewModel;

  @override
  void initState() {
    super.initState();
    _likeViewModel = getIt<LikeCubit>();
    _loadLikeStatus();
  }

  @override
  void didUpdateWidget(covariant FeedCardFooter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.post.id != widget.post.id ||
        oldWidget.post.likesCount != widget.post.likesCount) {
      _loadLikeStatus();
    }
  }

  @override
  void dispose() {
    _likeViewModel.close();
    super.dispose();
  }

  void _loadLikeStatus() {
    final postId = widget.post.id;

    if (postId == null || postId.trim().isEmpty) {
      return;
    }

    _likeViewModel.loadLikeStatus(
      postId: postId,
      initialLikesCount: widget.post.likesCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    final postId = widget.post.id;

    return BlocProvider.value(
      value: _likeViewModel,
      child: BlocConsumer<LikeCubit, LikeState>(
        listener: (context, state) {
          if (state.status == LikeStatus.error && state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          final likesCount = state.likesCount;
          final isLiked = state.isLiked;

          return Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: postId == null
                    ? null
                    : () =>
                          context.read<LikeCubit>().toggleLike(postId: postId),
                child: Icon(
                  isLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  size: 22.sp,
                  color: isLiked ? Colors.redAccent : AppColors.textSecondary,
                ),
              ),
              SizedBox(width: 6.w),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: postId == null
                    ? null
                    : () => showLikesBottomSheet(
                        context: context,
                        postId: postId,
                      ),
                child: Text(
                  '$likesCount',
                  style: AppStyles.body14SecondaryRegular,
                ),
              ),
              SizedBox(width: 16.w),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: postId == null
                    ? null
                    : () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => CommentScreen(post: widget.post),
                        ),
                      ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.mode_comment_outlined,
                      size: 22.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '${widget.post.commentsCount}',
                      style: AppStyles.body14SecondaryRegular,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                timeAgo(widget.post.createdAt),
                style: AppStyles.body14SecondaryRegular,
              ),
            ],
          );
        },
      ),
    );
  }
}
