import 'package:connect_hub/core/extensions/form_auth_scroll.dart';
import 'package:connect_hub/core/routing/routes.dart';
import 'package:connect_hub/core/utils/app_validator.dart';
import 'package:connect_hub/core/utils/show_message.dart';
import 'package:connect_hub/core/utils/validation_types.dart';
import 'package:connect_hub/core/widgets/app_button.dart';
import 'package:connect_hub/core/widgets/custom_text_form_field.dart';
import 'package:connect_hub/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:connect_hub/features/auth/presentation/cubits/auth_cubit/auth_state.dart';
import 'package:connect_hub/features/auth/presentation/widgets/custom_container.dart';
import 'package:connect_hub/features/auth/presentation/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class LoginFormCard extends StatefulWidget {
  const LoginFormCard({super.key});

  @override
  State<LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
            Text('Login', style: AppStyles.title18SemiBold),
            SizedBox(height: 4.h),
            Text(
              'Enter your credentials below',
              style: AppStyles.body14SecondaryRegular,
            ),
            SizedBox(height: 24.h),
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
            SizedBox(height: 16.h),
            PasswordField(
              validator: (value) => AppValidator.validate(
                min: 8,
                max: 16,
                value: value!,
                type: ValidationType.password,
              ),
              passwordController: passwordController,
            ),
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  await context.push(Routes.forgetPassword);
                  emailController.clear();
                  passwordController.clear();
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Forgot Password?',
                  style: AppStyles.body14Regular.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  context.go(Routes.home);
                } else if (state is AuthFailure) {
                  showMessage(
                    context,
                    'Login Failed',
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
                  text: 'Login',
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          if (formKey.validateAndScroll()) {
                            context.read<AuthCubit>().login(
                              email: emailController.text.trim(),
                              password: passwordController.text,
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
