import 'package:connect_hub/core/di/service_locator.dart';
import 'package:connect_hub/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/constant/app_constants.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  await setupLocator();
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
        return MultiBlocProvider(
          providers: [BlocProvider(create: (_) => getIt<AuthCubit>())],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'ConnectHub',
            theme: AppLightTheme.theme,
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
