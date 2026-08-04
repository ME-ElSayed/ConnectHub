import 'dart:io';
import 'package:connect_hub/core/extensions/form_auth_scroll.dart';
import 'package:connect_hub/core/routing/routes.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/core/utils/app_validator.dart';
import 'package:connect_hub/core/utils/show_message.dart';
import 'package:connect_hub/core/utils/validation_types.dart';
import 'package:connect_hub/core/widgets/app_button.dart';
import 'package:connect_hub/core/widgets/custom_text_form_field.dart';
import 'package:connect_hub/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:connect_hub/features/auth/presentation/cubits/auth_cubit/auth_state.dart';
import 'package:connect_hub/features/auth/presentation/widgets/custom_container.dart';
import 'package:connect_hub/features/auth/presentation/widgets/password_field.dart';
import 'package:connect_hub/features/auth/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterCard extends StatefulWidget {
  const RegisterCard({super.key});

  @override
  State<RegisterCard> createState() => _RegisterCardState();
}

class _RegisterCardState extends State<RegisterCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  File? avatarFile;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Register', style: AppStyles.title18SemiBold),
            SizedBox(height: 4.h),
            Text(
              'Enter your credentials below',
              style: AppStyles.body14SecondaryRegular,
            ),
            SizedBox(height: 15.h),
            Center(
              child: ProfileAvatar(
                onImageChanged: (file) {
                  setState(() => avatarFile = file);
                },
              ),
            ),
            SizedBox(height: 24.h),
            CustomTextFormField(
              validator: (value) => AppValidator.validate(
                value: value!,
                type: ValidationType.fullname,
              ),
              controller: nameController,
              hintText: 'your name',
              keyboardType: TextInputType.text,
              label: 'Name',
              prefixIcon: Icon(Icons.person, size: 25.r),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              validator: (value) => AppValidator.validate(
                value: value!,
                type: ValidationType.email,
              ),
              controller: emailController,
              hintText: 'you@email.com',
              keyboardType: TextInputType.emailAddress,
              label: 'Email',
              prefixIcon: Icon(Icons.email_outlined, size: 25.r),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16.h),
            PasswordField(
              validator: (value) => AppValidator.validate(
                min: 8,
                max: 16,
                value: value!,
                type: ValidationType.password,
              ),
              textInputAction: TextInputAction.next,
              passwordController: passwordController,
            ),
            SizedBox(height: 16.h),
            PasswordField(
              validator: (value) => AppValidator.validate(
                min: 8,
                max: 16,
                value: value!,
                type: ValidationType.confirmPassword,
                matchWith: passwordController.text,
              ),
              textInputAction: TextInputAction.done,
              passwordController: confirmPasswordController,
              hintText: 'confirm your password',
              label: 'Confirm Password',
            ),

            SizedBox(height: 24.h),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showMessage(
                    context,
                    'Registration Failed',
                    state.message,
                    Colors.red,
                    Colors.white,
                  );
                } else if (state is AuthSuccess) {
                  showMessage(
                    context,
                    'Registration Successful',
                    'You have successfully registered.',
                    Colors.green,
                    Colors.white,
                  );
                  context.go(Routes.home);
                }
              },
              builder: (context, state) {
                return AppButton(
                  isLoading: state is AuthLoading,
                  foregroundColor: Colors.blue,
                  text: 'Register',
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          if (formKey.validateAndScroll()) {
                            if (avatarFile == null) {
                              showMessage(
                                context,
                                'Missing Image',
                                'Please select a profile picture.',
                                Colors.orange,
                                Colors.white,
                              );
                              return;
                            }

                            context.read<AuthCubit>().register(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text,
                              image: avatarFile!,
                            );
                          }
                        },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
