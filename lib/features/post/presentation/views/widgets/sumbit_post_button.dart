import 'dart:io';

import 'package:connect_hub/core/extensions/form_auth_scroll.dart';
import 'package:connect_hub/core/utils/show_message.dart';
import 'package:connect_hub/core/widgets/app_button.dart';
import 'package:connect_hub/features/post/presentation/cubits/post_cubit/post_cubit.dart';
import 'package:connect_hub/features/post/presentation/cubits/post_cubit/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitPostButton extends StatelessWidget {
  const SubmitPostButton({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.contentController,
    required this.selectedImage,
    required this.onClearImage,
    this.onPosted,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final File? selectedImage;
  final VoidCallback onClearImage;
  final VoidCallback? onPosted;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        if (state.isSuccess) {
          showMessage(
            context,
            'Success',
            'Post created successfully.',
            Colors.green,
            Colors.white,
          );

          titleController.clear();
          contentController.clear();

          onClearImage();

          onPosted?.call();

          context.read<PostCubit>().reset();
        }

        if (state.errorMessage != null) {
          showMessage(
            context,
            'Error',
            state.errorMessage!,
            Colors.red,
            Colors.white,
          );
        }
      },
      builder: (context, state) {
        return AppButton(
          text: 'Post',
          foregroundColor: Colors.blue,
          isLoading: state.isLoading,
          onPressed: state.isLoading
              ? null
              : () {
                  if (!formKey.validateAndScroll()) return;

                  context.read<PostCubit>().createPost(
                    title: titleController.text.trim(),
                    content: contentController.text.trim(),
                    image: selectedImage,
                  );
                },
        );
      },
    );
  }
}
