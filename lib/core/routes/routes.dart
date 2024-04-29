import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/screens/signin_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../init_dependencies.dart';
import '../common/screens/onboarding/onboarding_screen.dart';
import '../constants/base_constants.dart';
import 'route_paths.dart';

class AppRouter {
  static GoRouter createRouter() {
    final sharedPreferences = serviceLocator<SharedPreferences>();
    bool isOnboardingComplete =
        sharedPreferences.getBool(CoreBaseConstants.isOnboardingComplete) ??
            false;

    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: isOnboardingComplete
          ? CoreRoutePaths.signin
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
        // Add other routes as needed
      ],
    );
  }
}
