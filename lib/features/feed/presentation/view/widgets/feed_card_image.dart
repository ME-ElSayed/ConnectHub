import 'package:connect_hub/core/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedCardImage extends StatelessWidget {
  const FeedCardImage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCachedImage(
      imageUrl:
          "https://i.ibb.co/SXrF9sL1/image-cropper-1785691682814.jpg",
      width: double.infinity,
      fit: BoxFit.cover,
      borderRadius: BorderRadius.circular(20.r),
    );
  }
}