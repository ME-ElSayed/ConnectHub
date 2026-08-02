import 'package:connect_hub/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordField extends StatefulWidget {
  final String? hintText;
  final String? label;
  final TextEditingController passwordController;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  const PasswordField({super.key, required this.passwordController, this.validator, this.hintText, this.label, this.textInputAction});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      validator: widget.validator,
      controller: widget.passwordController,
      hintText: widget.hintText ?? 'enter password',
      label: widget.label ??   'Password',
      obscureText: obscureText,
      prefixIcon: Icon(Icons.lock_outline, size: 25.r),
      suffixIcon: (obscureText)
          ? Icons.visibility_off_outlined
          : Icons.remove_red_eye_outlined,
      onSuffixIconPressed: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
      textInputAction: widget.textInputAction ?? TextInputAction.done,
    );
  }
}
