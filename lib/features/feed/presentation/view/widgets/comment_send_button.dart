import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/features/feed/presentation/cubits/comment_cubit.dart';
import 'package:connect_hub/features/feed/presentation/cubits/comment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentSendButton extends StatelessWidget {
  const CommentSendButton({
    super.key,
    required this.controller,
    required this.onSend,
  });

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentState>(
      buildWhen: (previous, current) =>
          previous.isAdding != current.isAdding,
      builder: (context, state) {
        return ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (_, value, _) {
            final canSend =
                value.text.trim().isNotEmpty &&
                    !state.isAdding;

            return IconButton(
              onPressed: canSend ? onSend : null,
              color: AppColors.primary,
              icon: state.isAdding
                  ? SizedBox(
                      width: 18.r,
                      height: 18.r,
                      child:
                          const CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(
                      Icons.send_rounded,
                    ),
            );
          },
        );
      },
    );
  }
}