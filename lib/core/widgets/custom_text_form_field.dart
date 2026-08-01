import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.validator,
    this.onChanged,
    this.onSubmit,
    this.onSuffixIconPressed,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final void Function(String)? onSubmit;
  final void Function()? onSuffixIconPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.body14Regular),
        SizedBox(height: 8.h),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 2.r,
                offset: Offset(0, 1.h),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            cursorColor: AppColors.primary,
            enabled: enabled,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            onFieldSubmitted: onSubmit,
            style: AppStyles.body16Regular.copyWith(
              color: AppColors.textPrimary,
            ),
            textInputAction: textInputAction,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppStyles.body16Regular.copyWith(
                color: AppColors.textSecondary,
              ),
              isDense: true,
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
              constraints: BoxConstraints(minHeight: 44.h),
              prefixIcon: prefixIcon == null
                  ? null
                  : Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 8.w),
                      child: prefixIcon,
                    ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 36.w,
                minHeight: 44.h,
              ),
              suffixIcon: suffixIcon == null
                  ? null
                  : Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 2.w),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: onSuffixIconPressed,
                        icon: Icon(suffixIcon, size: 25.r),
                      ),
                    ),
              suffixIconConstraints: BoxConstraints(
                minWidth: 40.w,
                minHeight: 44.h,
              ),
              enabledBorder: _border(AppColors.border),
              focusedBorder: _border(AppColors.primary),
              errorBorder: _border(Colors.red),
              focusedErrorBorder: _border(Colors.red),
              disabledBorder: _border(AppColors.border),
            ),
          ),
        ),
      ],
    );
  }

  static OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color),
    );
  }
}
