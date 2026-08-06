import 'package:connect_hub/core/utils/app_validator.dart';
import 'package:connect_hub/core/utils/validation_types.dart';
import 'package:connect_hub/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostFields extends StatelessWidget {
  const PostFields({
    super.key,
    required this.titleController,
    required this.contentController,
  });

  final TextEditingController titleController;
  final TextEditingController contentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: titleController,
          label: 'Title',
          hintText: 'Give your post a title',
          validator: (value) => AppValidator.validate(
            value: value!,
            type: ValidationType.title,
            max: 100,
          ),
        ),

        SizedBox(height: 16.h),

        CustomTextFormField(
          controller: contentController,
          label: 'Description',
          hintText: 'What do you want to share?',
          maxlines: 5,
          validator: (value) => AppValidator.validate(
            value: value!,
            type: ValidationType.content,
            max: 500,
          ),
        ),
      ],
    );
  }
}
