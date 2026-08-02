import 'package:connect_hub/features/auth/presentation/widgets/auth_footer.dart';
import 'package:connect_hub/features/auth/presentation/widgets/auth_header.dart';
import 'package:connect_hub/features/auth/presentation/widgets/register_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
                    title: 'Create Account',
                    subtitle:
                        'Enter your credentials below to create a new account.',
                  ),
                  SizedBox(height: 32.h),
                  const RegisterCard(),
                  SizedBox(height: 32.h),
                  AuthFooter(
                    message: 'Already have an account?',
                    actionText: 'Login',
                    onActionTap: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
