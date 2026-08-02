import 'dart:io';

import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class ImageService {
  ImageService._();

  static final ImagePicker _picker = ImagePicker();

  static const int _maxImageSize = 5 * 1024 * 1024;

  static Future<File?> pickAndCropImage(BuildContext context) async {
    try {
      final XFile? picked = await _pickImage(context);

      if (picked == null) return null;

      if (!_validateImage(picked.path, context)) {
        return null;
      }

      final CroppedFile? cropped = await _cropImage(picked.path);

      if (cropped == null) return null;

      return File(cropped.path);
    } catch (e) {
      debugPrint("ImageService Error: $e");

      if (context.mounted) {
        showMessage(
          context,
          "Error",
          "Unable to select image.",
          Colors.red,
          Colors.white,
        );
      }

      return null;
    }
  }

  static Future<XFile?> _pickImage(BuildContext context) async {
    return await showModalBottomSheet<XFile>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  title: Center(
                    child: Text(
                      "Select Image",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const Divider(),

                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Gallery"),
                  onTap: () async {
                    final file = await _picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 90,
                    );

                    if (context.mounted) {
                      Navigator.pop(context, file);
                    }
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () async {
                    final file = await _picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 90,
                    );

                    if (context.mounted) {
                      Navigator.pop(context, file);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static bool _validateImage(
    String path,
    BuildContext context,
  ) {
    final mimeType = lookupMimeType(path);

    if (mimeType != 'image/png' &&
        mimeType != 'image/jpeg' &&
        mimeType != 'image/jpg') {
      showMessage(
        context,
        "Invalid File",
        "Please select a PNG or JPG image.",
        Colors.red,
        Colors.white,
      );
      return false;
    }

    final file = File(path);

    if (file.lengthSync() > _maxImageSize) {
      showMessage(
        context,
        "Image Too Large",
        "Maximum size is 5 MB.",
        Colors.red,
        Colors.white,
      );
      return false;
    }

    return true;
  }

  static Future<CroppedFile?> _cropImage(String path) async {
    return ImageCropper().cropImage(
      sourcePath: path,
      compressQuality: 90,
      aspectRatio: const CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Crop Image",
          toolbarColor: AppColors.primary,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: "Crop Image",
        ),
      ],
    );
  }
}


