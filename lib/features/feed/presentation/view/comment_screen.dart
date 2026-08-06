import 'package:connect_hub/core/di/service_locator.dart';
import 'package:connect_hub/features/feed/presentation/cubits/comment_cubit.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/comment_screen_body.dart';
import 'package:connect_hub/features/post/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final postId = post.id;

    if (postId == null || postId.trim().isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('Post id is missing.'),
        ),
      );
    }

    return BlocProvider(
      create: (_) => getIt<CommentCubit>()
        ..watchComments(postId),
      child: CommentScreenBody(
        postId: postId,
      ),
    );
  }
}