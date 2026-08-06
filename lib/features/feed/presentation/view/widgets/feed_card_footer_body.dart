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

class FeedCardFooterBody extends StatelessWidget {
  const FeedCardFooterBody({super.key, 
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final postId = post.id;

    return BlocConsumer<LikeCubit, LikeState>(
      listener: (context, state) {
        if (state.status == LikeStatus.error &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
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
                  : () => context.read<LikeCubit>().toggleLike(
                        postId: postId,
                      ),
              onCountTap: postId == null
                  ? null
                  : () => showLikesBottomSheet(
                        context: context,
                        postId: postId,
                      ),
            ),
            SizedBox(width: 16.w),
            CommentButton(
              commentsCount: post.commentsCount,
              onTap: postId == null
                  ? null
                  : () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CommentScreen(post: post),
                        ),
                      );
                    },
            ),
            const Spacer(),
            PostTimeLabel(
              createdAt: post.createdAt,
            ),
          ],
        );
      },
    );
  }
}