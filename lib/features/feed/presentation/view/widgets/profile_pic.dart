import 'package:connect_hub/core/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.imageUrl,
    required this.size ,
  });

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AppCachedImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      fit: BoxFit.cover,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }
}