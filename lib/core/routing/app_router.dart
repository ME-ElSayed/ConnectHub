import 'package:go_router/go_router.dart';

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
    ],
  );
}
