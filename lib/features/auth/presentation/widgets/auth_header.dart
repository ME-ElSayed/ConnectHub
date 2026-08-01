import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_styles.dart';
import 'auth_logo.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    this.title = 'ConnectHub',
    this.subtitle = 'Welcome back, sign in to continue',
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AuthLogo(),
        SizedBox(height: 12.h),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppStyles.title20SemiBold,
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppStyles.body14SecondaryRegular,
        ),
      ],
    );
  }
}
