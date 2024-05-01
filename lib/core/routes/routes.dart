import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/screens/signin_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../init_dependencies.dart';
import '../constants/core_constants.dart';
import 'route_paths.dart';

class AppRouter {
  static GoRouter createRouter() {
    final sharedPreferences = serviceLocator<SharedPreferences>();
    bool isOnboardingComplete =
        sharedPreferences.getBool(CoreConstants.isOnboardingComplete) ?? false;
    String? userToken = sharedPreferences.getString(CoreConstants.userToken);

    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: isOnboardingComplete
          ? (userToken != null ? CoreRoutePaths.home : CoreRoutePaths.signin)
          : CoreRoutePaths.onboarding,
      routes: <GoRoute>[
        GoRoute(
          path: CoreRoutePaths.onboarding,
          builder: (BuildContext context, GoRouterState state) =>
              const OnboardingScreen(),
        ),
        GoRoute(
          path: CoreRoutePaths.signin,
          builder: (BuildContext context, GoRouterState state) =>
              const SignInScreen(),
        ),
        GoRoute(
          path: CoreRoutePaths.signup,
          builder: (BuildContext context, GoRouterState state) =>
              const SignUpScreen(),
        ),
        GoRoute(
          path: CoreRoutePaths.home,
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
        ),
        // Add other routes as needed
      ],
    );
  }
}
