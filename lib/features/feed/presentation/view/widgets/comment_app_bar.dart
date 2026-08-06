import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class CommentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CommentAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Comments',
        style: AppStyles.title18SemiBold,
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);
}