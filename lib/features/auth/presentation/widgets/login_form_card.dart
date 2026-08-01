import 'package:connect_hub/core/widgets/app_button.dart';
import 'package:connect_hub/core/widgets/custom_text_form_field.dart';
import 'package:connect_hub/features/auth/presentation/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class LoginFormCard extends StatefulWidget {
  const LoginFormCard({
    super.key,
    
  });

  @override
  State<LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard> {
  final GlobalKey<FormState> formKey=GlobalKey<FormState>();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 15.r,
            spreadRadius: -3.r,
            offset: Offset(0, 10.h),
          ),
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6.r,
            spreadRadius: -4.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Login', style: AppStyles.title18SemiBold),
            SizedBox(height: 4.h),
            Text(
              'Enter your credentials below',
              style: AppStyles.body14SecondaryRegular,
            ),
            SizedBox(height: 24.h),
            CustomTextFormField(
              controller: emailController,
              hintText: 'you@email.com',
              keyboardType: TextInputType.emailAddress,
              label: 'Email',
              prefixIcon: Icon(Icons.email_outlined, size: 25.r),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16.h),
           PasswordField(
              passwordController: passwordController,
            ),
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Handle forgot password press
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Forgot Password?',
                  style: AppStyles.body14Regular.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            AppButton(text: 'Login', onPressed: (){}),
          ],
        ),
      ),
    );
  }
}



