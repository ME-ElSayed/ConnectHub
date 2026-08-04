import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect_hub/core/services/image_service.dart';
import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostImage extends StatefulWidget {
  const PostImage({super.key, this.imageUrl, this.onImageChanged});

  final String? imageUrl;
  final ValueChanged<File?>? onImageChanged;

  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final image = await ImageService.pickAndCropImage(context);

    if (image == null) return;

    setState(() {
      _pickedImage = image;
    });

    widget.onImageChanged?.call(image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: SizedBox(
        height: 200.h,
        width: double.infinity,
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_pickedImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.file(_pickedImage!, fit: BoxFit.cover),
      );
    }

    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: CachedNetworkImage(
          imageUrl: widget.imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.broken_image),
        ),
      );
    }

    return DottedBorder(
      options: RectDottedBorderOptions(
        color: AppColors.neutral200,
        dashPattern: const [5, 6],
        strokeWidth: .9,
        borderPadding: EdgeInsets.zero,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 40.r,
              color: AppColors.primary,
            ),
            SizedBox(height: 10.h),
            Text(
              "Add Photo",
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}
