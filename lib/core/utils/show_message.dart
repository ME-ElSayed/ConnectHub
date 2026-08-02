import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showMessage(
  BuildContext context,
  String title,
  String message,
  Color backgroundcolor,
  Color textColor,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: textColor)),
          SizedBox(height: 5.h),
          Text(message, style: TextStyle(color: textColor)),
        ],
      ),
      // ignore: deprecated_member_use
      backgroundColor: backgroundcolor.withOpacity(0.8),
      duration: const Duration(seconds: 3),
    ),
  );
}
