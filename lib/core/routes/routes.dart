import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../init_dependencies.dart';
import '../common/screens/onboarding/onboarding_screen.dart';

class AppRouter {
  static GoRouter createRouter() {
    final sharedPreferences = serviceLocator<SharedPreferences>();
    bool isOnboardingComplete =
        sharedPreferences.getBool('isOnboardingComplete') ?? false;

    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: isOnboardingComplete ? '/login' : '/onboarding',
      routes: <GoRoute>[
        GoRoute(
          path: '/onboarding',
          builder: (BuildContext context, GoRouterState state) =>
              const OnboardingScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) =>
              const LoginScreen(),
        ),
        // Add other routes as needed
      ],
    );
  }
}
