import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/core/widgets/app_button.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.isLoggingOut,
    required this.onLogout,
  });

  final String name;
  final String? imageUrl;
  final bool isLoggingOut;
  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(
          imageUrl:
              imageUrl ??
              "https://i.ibb.co/SXrF9sL1/image-cropper-1785691682814.jpg",
          size: 112.r,
        ),
        SizedBox(height: 16.h),
        Text(name, style: AppStyles.title20SemiBold),
        SizedBox(height: 4.h),
        Text(
          'Product designer & coffee lover ✦ Sharing ideas,\n'
          'travel & everyday moments.',
          textAlign: TextAlign.center,
          style: AppStyles.body14Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 20.h),
        AppButton(
          backgroundColor: Colors.red,
          foregroundColor: Colors.red,
          text: "logout",
          onPressed: onLogout,
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
