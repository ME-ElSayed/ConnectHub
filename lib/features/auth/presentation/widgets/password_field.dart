import 'package:connect_hub/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  const PasswordField({super.key, required this.passwordController});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.passwordController,
      hintText: 'enter password',
      label: 'Password',
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
      textInputAction: TextInputAction.done,
    );
  }
}
