import 'package:flutter/material.dart';

import '../../../../core/theme/app_styles.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    this.message = "Don't have an account?",
    this.actionText = 'Register',
    this.onActionTap,
  });

  final String message;
  final String actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(message, style: AppStyles.body14SecondaryRegular),
        GestureDetector(
          onTap: onActionTap,
          child: Text(
            actionText,
            style: AppStyles.body14Regular.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
