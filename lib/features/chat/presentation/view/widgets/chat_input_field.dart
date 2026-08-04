import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    this.hintText = 'Ask for post ideas...',
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      minLines: 1,
      maxLines: 4,
      textInputAction: TextInputAction.send,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.auto_awesome_rounded, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.neutral200,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        border: _border(color: AppColors.border),
        enabledBorder: _border(color: AppColors.border),
        focusedBorder: _border(color: AppColors.primary, width: 1.5),
      ),
    );
  }

  OutlineInputBorder _border({Color? color, double width = 2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.r),
      borderSide: BorderSide(color: color ?? Colors.transparent, width: width),
    );
  }
}
