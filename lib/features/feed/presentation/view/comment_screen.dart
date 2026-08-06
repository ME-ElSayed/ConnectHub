import 'package:connect_hub/core/constant/app_constants.dart';
import 'package:connect_hub/core/di/service_locator.dart';
import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/core/utils/time_ago.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/profile_pic.dart';
import 'package:connect_hub/features/feed/presentation/cubits/comment_state.dart';
import 'package:connect_hub/features/feed/presentation/cubits/comment_cubit.dart';
import 'package:connect_hub/features/post/data/models/comment_model.dart';
import 'package:connect_hub/features/post/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final postId = post.id;

    if (postId == null || postId.trim().isEmpty) {
      return const Scaffold(body: Center(child: Text('Post id is missing.')));
    }

    return BlocProvider(
      create: (_) => getIt<CommentCubit>()..watchComments(postId),
      child: _CommentScreenBody(postId: postId),
    );
  }
}

class _CommentScreenBody extends StatefulWidget {
  const _CommentScreenBody({required this.postId});

  final String postId;

  @override
  State<_CommentScreenBody> createState() => _CommentScreenBodyState();
}

class _CommentScreenBodyState extends State<_CommentScreenBody> {
  final TextEditingController _commentController = TextEditingController();
  String? _lastSubmittedMessage;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentCubit, CommentState>(
      listener: (context, state) {
        if (state.status == CommentStatus.success) {
          final currentMessage = _commentController.text.trim();
          if (currentMessage == _lastSubmittedMessage) {
            _commentController.clear();
          }
          _lastSubmittedMessage = null;
        }

        if (state.status == CommentStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text('Comments', style: AppStyles.title18SemiBold),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              const Expanded(child: _CommentsList()),
              _CommentComposer(
                controller: _commentController,
                onSend: _sendComment,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendComment() {
    final message = _commentController.text.trim();

    if (message.isEmpty) {
      return;
    }

    _lastSubmittedMessage = message;
    context.read<CommentCubit>().addComment(
      postId: widget.postId,
      message: message,
    );
  }
}

class _CommentsList extends StatelessWidget {
  const _CommentsList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentState>(
      builder: (context, state) {
        if (state.isLoading && state.comments.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.comments.isEmpty) {
          return Center(
            child: Text(
              'Be the first to comment.',
              style: AppStyles.body14SecondaryRegular,
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
          itemCount: state.comments.length,
          separatorBuilder: (_, _) => SizedBox(height: 14.h),
          itemBuilder: (context, index) {
            return _CommentTile(comment: state.comments[index]);
          },
        );
      },
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment});

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    final username = comment.username.trim().isEmpty
        ? 'Unknown user'
        : comment.username.trim();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePic(imageUrl: comment.profileImageUrl, size: 38.r),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      username,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.label14SemiBold,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    timeAgo(comment.createdAt),
                    style: AppStyles.body12SecondaryRegular,
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Text(
                comment.message,
                style: AppStyles.body14Regular.copyWith(height: 1.35),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CommentComposer extends StatelessWidget {
  const _CommentComposer({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentState>(
      buildWhen: (previous, current) => previous.isAdding != current.isAdding,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 10.h),
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 4,
                  maxLength: AppConstants.maxCommentLength,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: 'Write a comment...',
                    hintStyle: AppStyles.body14SecondaryRegular,
                    counterText: '',
                    filled: true,
                    fillColor: AppColors.neutral100,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
                builder: (context, value, child) {
                  final canSend =
                      value.text.trim().isNotEmpty && !state.isAdding;

                  return IconButton(
                    onPressed: canSend ? onSend : null,
                    icon: state.isAdding
                        ? SizedBox(
                            width: 18.r,
                            height: 18.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.send_rounded),
                    color: AppColors.primary,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
