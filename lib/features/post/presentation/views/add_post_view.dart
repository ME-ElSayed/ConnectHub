import 'package:connect_hub/core/extensions/form_auth_scroll.dart';
import 'package:connect_hub/core/utils/app_validator.dart';
import 'package:connect_hub/core/utils/validation_types.dart';
import 'package:connect_hub/core/widgets/app_button.dart';
import 'package:connect_hub/core/widgets/custom_text_form_field.dart';
import 'package:connect_hub/features/post/presentation/views/widgets/post_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 420.w),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  CustomTextFormField(
                    validator: (value) => AppValidator.validate(
                      value: value!,
                      type: ValidationType.title,
                      max: 100,
                    ),
                    controller: titleController,
                    hintText: 'Give your post a title',
                    keyboardType: TextInputType.emailAddress,
                    label: 'Title',
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    validator: (value) => AppValidator.validate(
                      value: value!,
                      type: ValidationType.content,
                      max: 100,
                    ),
                    maxlines: 5,
                    controller: contentController,
                    hintText: 'What do you want to share?',
                    keyboardType: TextInputType.emailAddress,
                    label: ' Description',
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 24.h),
                  PostImage(),
                  SizedBox(height: 24.h),
                  AppButton(
                    foregroundColor: Colors.blue,
                    text: 'Post',
                    onPressed: () {
                      if (formKey.validateAndScroll()) {}
                    },
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
