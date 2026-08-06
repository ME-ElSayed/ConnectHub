import 'package:connect_hub/core/di/service_locator.dart';
import 'package:connect_hub/core/widgets/custom_transition_page.dart';
import 'package:connect_hub/core/widgets/main_navigation_scafold.dart';
import 'package:connect_hub/features/auth/presentation/view/forget_password_view.dart';
import 'package:connect_hub/features/auth/presentation/view/login_view.dart';
import 'package:connect_hub/features/auth/presentation/view/register_view.dart';
import 'package:connect_hub/features/post/presentation/cubits/post_cubit/post_cubit.dart';
import 'package:connect_hub/features/splash/presentation/view/splash_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

class AppRouter {
  AppRouter._();

  static const Set<String> _publicRoutes = {
    Routes.splash,
    Routes.login,
    Routes.register,
    Routes.forgetPassword,
  };

  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      final location = state.matchedLocation;

      if (user == null) {
        if (_publicRoutes.contains(location)) {
          return null;
        }

        return Routes.login;
      }

      if (_publicRoutes.contains(location)) {
        return Routes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashView(),
      ),

      GoRoute(
        path: Routes.login,
        name: RouteNames.login,
        pageBuilder: (context, state) => buildPageWithTransition(
          context: context,
          state: state,
          child: const LoginView(),
        ),
      ),

      GoRoute(
        path: Routes.forgetPassword,
        name: RouteNames.forgetPassword,
        pageBuilder: (context, state) => buildPageWithTransition(
          context: context,
          state: state,
          child: ForgetPasswordView(),
        ),
      ),

      GoRoute(
        path: Routes.register,
        name: RouteNames.register,
        pageBuilder: (context, state) => buildPageWithTransition(
          context: context,
          state: state,
          child: const RegisterView(),
        ),
      ),

      GoRoute(
        path: Routes.home,
        name: RouteNames.home,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<PostCubit>()),
          ],
          child: MainScreen(),
        ),
      ),
    ],
  );
}