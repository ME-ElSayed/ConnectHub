import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/widgets.dart';

class LoginFormCard extends StatelessWidget {
  const LoginFormCard({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.onPasswordVisibilityTap,
    required this.onLoginPressed,
    this.onForgotPasswordTap,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final VoidCallback onPasswordVisibilityTap;
  final VoidCallback onLoginPressed;
  final VoidCallback? onForgotPasswordTap;

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
              prefixIcon: _FieldIcon(assetName: AppAssets.mail),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              controller: passwordController,
              hintText: '\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022',
              label: 'Password',
              obscureText: !isPasswordVisible,
              prefixIcon: _FieldIcon(assetName: AppAssets.lock),
              suffixIcon: _PasswordVisibilityButton(
                onTap: onPasswordVisibilityTap,
              ),
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onForgotPasswordTap,
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
            AppButton(text: 'Login', onPressed: onLoginPressed),
          ],
        ),
      ),
    );
  }
}

class _FieldIcon extends StatelessWidget {
  const _FieldIcon({required this.assetName});

  final String assetName;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: 16.r,
      height: 16.r,
      fit: BoxFit.fill,
    );
  }
}

class _PasswordVisibilityButton extends StatelessWidget {
  const _PasswordVisibilityButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SvgPicture.asset(
        AppAssets.eye,
        width: 16.r,
        height: 16.r,
        fit: BoxFit.fill,
      ),
    );
  }
}
