import 'package:connect_hub/core/utils/app_validator.dart';
import 'package:connect_hub/core/utils/show_message.dart';
import 'package:connect_hub/core/utils/validation_types.dart';
import 'package:connect_hub/core/widgets/app_button.dart';
import 'package:connect_hub/core/widgets/custom_text_form_field.dart';
import 'package:connect_hub/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:connect_hub/features/auth/presentation/cubits/auth_cubit/auth_state.dart';
import 'package:connect_hub/features/auth/presentation/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassCard extends StatefulWidget {
  const ForgetPassCard({super.key});

  @override
  State<ForgetPassCard> createState() => _ForgetPassCardState();
}

class _ForgetPassCardState extends State<ForgetPassCard> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              validator: (value) => AppValidator.validate(
                value: value!,
                type: ValidationType.email,
              ),
              controller: emailController,
              hintText: 'you@email.com',
              keyboardType: TextInputType.emailAddress,
              label: 'Email',
              prefixIcon: Icon(Icons.email_outlined, size: 25.r),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20.h),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  showMessage(
                    context,
                    "sending",
                    "sending successfully",
                    Colors.green,
                    Colors.white,
                  );
                } else if (state is AuthFailure) {
                  showMessage(
                    context,
                    'sending Failed',
                    state.message,
                    Colors.red,
                    Colors.white,
                  );
                }
              },
              builder: (context, state) {
                return AppButton(
                  isLoading: state is AuthLoading,
                  foregroundColor: Colors.blue,
                  text: 'Send Reset Link',
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().resetPassword(
                              email: emailController.text.trim(),
                            );
                          }
                        },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
