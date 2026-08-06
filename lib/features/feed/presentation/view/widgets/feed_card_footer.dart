import 'package:connect_hub/core/di/service_locator.dart';
import 'package:connect_hub/features/feed/presentation/cubits/like_cubit.dart';
import 'package:connect_hub/features/feed/presentation/cubits/like_state.dart';
import 'package:connect_hub/features/feed/presentation/view/comment_screen.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/comment_button.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/like_button.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/likes_bottom_sheet.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/post_time_label.dart';
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
  late final LikeCubit _likeCubit;

  @override
  void initState() {
    super.initState();

    _likeCubit = getIt<LikeCubit>();

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
    _likeCubit.close();
    super.dispose();
  }

  void _loadLikeStatus() {
    final postId = widget.post.id;

    if (postId == null || postId.trim().isEmpty) {
      return;
    }

    _likeCubit.loadLikeStatus(
      postId: postId,
      initialLikesCount: widget.post.likesCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    final postId = widget.post.id;

    return BlocProvider.value(
      value: _likeCubit,
      child: BlocConsumer<LikeCubit, LikeState>(
        listener: (context, state) {
          if (state.status == LikeStatus.error && state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          return Row(
            children: [
              LikeButton(
                isLiked: state.isLiked,
                likesCount: state.likesCount,
                onLike: postId == null
                    ? null
                    : () {
                        context.read<LikeCubit>().toggleLike(postId: postId);
                      },
                onCountTap: postId == null
                    ? null
                    : () {
                        showLikesBottomSheet(context: context, postId: postId);
                      },
              ),

              SizedBox(width: 16.w),

              CommentButton(
                commentsCount: widget.post.commentsCount,
                onTap: postId == null
                    ? null
                    : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CommentScreen(post: widget.post),
                          ),
                        );
                      },
              ),

              const Spacer(),

              PostTimeLabel(createdAt: widget.post.createdAt),
            ],
          );
        },
      ),
    );
  }
}
