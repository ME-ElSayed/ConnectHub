import 'package:flutter/material.dart';

void showMessage(
    BuildContext context, String title, String message, Color backgroundcolor, Color textColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      // ignore: deprecated_member_use
      backgroundColor: backgroundcolor.withOpacity(0.8),
      duration: const Duration(seconds: 3),
    ),
  );
}

