import 'package:connect_hub/features/feed/presentation/cubits/comment_cubit.dart';
import 'package:connect_hub/features/feed/presentation/cubits/comment_state.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/comment_app_bar.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/comment_composer.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/comments_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreenBody extends StatefulWidget {
  const CommentScreenBody({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  State<CommentScreenBody> createState() =>
      _CommentScreenBodyState();
}

class _CommentScreenBodyState
    extends State<CommentScreenBody> {
  final TextEditingController _controller =
      TextEditingController();

  String? _lastSubmittedMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendComment() {
    final message = _controller.text.trim();

    if (message.isEmpty) {
      return;
    }

    _lastSubmittedMessage = message;

    context.read<CommentCubit>().addComment(
          postId: widget.postId,
          message: message,
        );
  }

  void _handleState(CommentState state) {
    if (state.status == CommentStatus.success) {
      final current = _controller.text.trim();

      if (current == _lastSubmittedMessage) {
        _controller.clear();
      }

      _lastSubmittedMessage = null;
    }

    if (state.status == CommentStatus.error &&
        state.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentCubit, CommentState>(
      listener: (_, state) => _handleState(state),
      builder: (_, _) {
        return Scaffold(
          appBar: const CommentAppBar(),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                const Expanded(
                  child: CommentsList(),
                ),
                CommentComposer(
                  controller: _controller,
                  onSend: _sendComment,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}