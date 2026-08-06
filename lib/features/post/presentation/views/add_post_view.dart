import 'dart:io';
import 'package:connect_hub/core/extensions/form_auth_scroll.dart';
import 'package:connect_hub/core/utils/app_validator.dart';
import 'package:connect_hub/core/utils/show_message.dart';
import 'package:connect_hub/core/utils/validation_types.dart';
import 'package:connect_hub/core/widgets/app_button.dart';
import 'package:connect_hub/core/widgets/custom_text_form_field.dart';
import 'package:connect_hub/features/post/presentation/cubits/post_cubit/post_cubit.dart';
import 'package:connect_hub/features/post/presentation/cubits/post_cubit/post_state.dart';
import 'package:connect_hub/features/post/presentation/views/widgets/post_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPostView extends StatefulWidget {
  final VoidCallback? onPosted;
  const AddPostView({super.key, this.onPosted});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  File? selectedImage;

  void _onImageChanged(File? image) {
    setState(() {
      selectedImage = image;
    });
  }

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
                    keyboardType: TextInputType.text,
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
                    keyboardType: TextInputType.multiline,
                    label: 'Description',
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 24.h),
                  PostImage(
                     selectedImage: selectedImage,
                    onImageChanged: _onImageChanged),
                  SizedBox(height: 24.h),
                  BlocConsumer<PostCubit, PostState>(
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
                        widget.onPosted!.call();
                        setState(() {
                          selectedImage = null;
                        });
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
                        foregroundColor: Colors.blue,
                        text: 'Post',
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
