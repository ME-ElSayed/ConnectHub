import 'package:connect_hub/features/auth/presentation/widgets/auth_header.dart';
import 'package:connect_hub/features/auth/presentation/widgets/forget_pass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 420.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthHeader(
                    title: 'Forgot Password?',
                    subtitle: 'Enter your email address and we will send you a link to reset your password.',
                  ),
                  SizedBox(height: 32.h),
                  const ForgetPassCard(),
                  SizedBox(height: 32.h),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}