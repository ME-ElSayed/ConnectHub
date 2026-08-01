import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final VoidCallback? onSuffixIconPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodyMedium),
        SizedBox(height: 8.h),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onSubmit,
            cursorColor: theme.colorScheme.primary,
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: hintText,
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
                  : IconButton(
                      onPressed: onSuffixIconPressed,
                      icon: Icon(suffixIcon),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
