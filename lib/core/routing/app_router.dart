import 'package:connect_hub/features/auth/presentation/view/forget_password_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/view/login_view.dart';
import '../../features/splash/presentation/view/splash_view.dart';
import 'routes.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: Routes.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: Routes.forgetPassword,
        name: RouteNames.forgetPassword,
        builder: (context, state) => const ForgetPasswordView(),
      ),
    ],
  );
}
