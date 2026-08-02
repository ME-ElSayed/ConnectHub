import 'package:connect_hub/core/extensions/form_auth_scroll.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/core/utils/app_assets.dart';
import 'package:connect_hub/core/utils/app_validator.dart';
import 'package:connect_hub/core/utils/validation_types.dart';
import 'package:connect_hub/core/widgets/app_button.dart';
import 'package:connect_hub/core/widgets/custom_text_form_field.dart';
import 'package:connect_hub/features/auth/presentation/widgets/custom_container.dart';
import 'package:connect_hub/features/auth/presentation/widgets/password_field.dart';
import 'package:connect_hub/features/auth/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                isLoading: false,
                image: Image.asset(AppAssets.avatar, fit: BoxFit.cover),
                icon: Icons.camera_alt_outlined,
                onPressed: () {},
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
            AppButton(
              text: 'Register',
              onPressed: () {
                if (!formKey.validateAndScroll()) {
                  // Handle registration logic here
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
