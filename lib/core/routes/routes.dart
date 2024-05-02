import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/screens/signin_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/feature2/presentation/screens/feature2_screen.dart';
import '../../features/feature3/presentation/screens/feature3_screen.dart';
import '../../features/feature4/presentation/screens/feature4_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/main/presentation/screens/main_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../init_dependencies.dart';
import '../constants/core_constants.dart';
import 'route_paths.dart';

class AppRouter {
  static GoRouter createRouter() {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();
    final sharedPreferences = serviceLocator<SharedPreferences>();
    bool isOnboardingComplete =
        sharedPreferences.getBool(CoreConstants.isOnboardingComplete) ?? false;
    String? userToken = sharedPreferences.getString(CoreConstants.userToken);

    return GoRouter(
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: isOnboardingComplete
          ? (userToken != null ? CoreRoutePaths.main : CoreRoutePaths.signin)
          : CoreRoutePaths.onboarding,
      routes: [
        GoRoute(
          path: CoreRoutePaths.onboarding,
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const OnboardingScreen(),
          ),
        ),
        GoRoute(
          path: CoreRoutePaths.signin,
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const SignInScreen(),
          ),
        ),
        GoRoute(
          path: CoreRoutePaths.signup,
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const SignUpScreen(),
          ),
        ),
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) => MainScreen(child: child),
          routes: [
            GoRoute(
              path: CoreRoutePaths.main,
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: const HomeScreen(),
              ),
            ),
            GoRoute(
              path: CoreRoutePaths.feature2, // Matches '/users'
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: const Feature2Screen(),
              ),
            ),
            GoRoute(
              path: CoreRoutePaths.feature3, // Matches '/notifications'
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: const Feature3Screen(),
              ),
            ),
            GoRoute(
              path: CoreRoutePaths.feature4, // Matches '/settings'
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: const Feature4Screen(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class NoTransitionPage<T> extends CustomTransitionPage<T> {
  NoTransitionPage({super.key, required super.child})
      : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child; // No animation
          },
        );
}
