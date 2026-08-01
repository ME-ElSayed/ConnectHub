import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/auth_footer.dart';
import '../widgets/auth_header.dart';
import '../widgets/login_form_card.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                  const AuthHeader(),
                  SizedBox(height: 32.h),
                  LoginFormCard(),
                  SizedBox(height: 32.h),
                  const AuthFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
