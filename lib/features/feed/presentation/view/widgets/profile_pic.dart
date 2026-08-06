import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key, required this.imageUrl, required this.size});

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.trim().isEmpty) {
      return CircleAvatar(
        radius: size / 2,
        backgroundColor: AppColors.neutral100,
        child: Icon(
          Icons.person_outline_rounded,
          size: size * 0.52,
          color: AppColors.textSecondary,
        ),
      );
    }

    return AppCachedImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      fit: BoxFit.cover,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }
}
