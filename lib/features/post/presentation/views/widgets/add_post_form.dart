import 'dart:io';

import 'package:connect_hub/features/post/presentation/views/widgets/post_fields.dart';
import 'package:connect_hub/features/post/presentation/views/widgets/post_image.dart';
import 'package:connect_hub/features/post/presentation/views/widgets/sumbit_post_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPostForm extends StatelessWidget {
  const AddPostForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.contentController,
    required this.selectedImage,
    required this.onImageChanged,
    required this.onClearImage,
    this.onPosted,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final File? selectedImage;
  final ValueChanged<File?> onImageChanged;
  final VoidCallback onClearImage;
  final VoidCallback? onPosted;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 24.h),

              PostFields(
                titleController: titleController,
                contentController: contentController,
              ),

              SizedBox(height: 24.h),

              PostImage(
                selectedImage: selectedImage,
                onImageChanged: onImageChanged,
              ),

              SizedBox(height: 24.h),

              SubmitPostButton(
                formKey: formKey,
                titleController: titleController,
                contentController: contentController,
                selectedImage: selectedImage,
                onClearImage: onClearImage,
                onPosted: onPosted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}