import 'package:connect_hub/core/di/service_locator.dart';
import 'package:connect_hub/features/feed/presentation/cubits/like_cubit.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/feed_card_footer_body.dart';
import 'package:connect_hub/features/post/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedCardFooter extends StatelessWidget {
  const FeedCardFooter({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final postId = post.id;

    return BlocProvider(
      create: (_) {
        final cubit = getIt<LikeCubit>();

        if (postId != null && postId.trim().isNotEmpty) {
          cubit.loadLikeStatus(
            postId: postId,
            initialLikesCount: post.likesCount,
          );
        }

        return cubit;
      },
      child: FeedCardFooterBody(post: post),
    );
  }
}
