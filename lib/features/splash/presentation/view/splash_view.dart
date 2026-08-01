import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/splash_brand_content.dart';
import '../widgets/splash_gradient_background.dart';
import '../widgets/splash_loading_indicator.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.transparent,
        systemNavigationBarColor: AppColors.primaryLight,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: SplashGradientBackground(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  const Expanded(child: Center(child: SplashBrandContent())),
                  Padding(
                    padding: EdgeInsets.only(bottom: 64.h),
                    child: const SplashLoadingIndicator(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
