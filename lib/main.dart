import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constant/app_constants.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        AppConstants.designWidth,
        AppConstants.designHeight,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'ConnectHub',
          theme: AppLightTheme.theme,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
