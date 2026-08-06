import 'package:connect_hub/core/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedCardImage extends StatelessWidget {
  const FeedCardImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.56,
      child: AppCachedImage(
        imageUrl: imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        borderRadius: BorderRadius.circular(20.r),
      ),
    );
  }
}
