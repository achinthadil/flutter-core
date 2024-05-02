import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/screens/signin_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/main/presentation/screens/main_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/users/presentation/screens/users_screen.dart';
import '../../init_dependencies.dart';
import '../constants/core_constants.dart';

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
          ? (userToken != null ? '/' : '/signin')
          : '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const OnboardingScreen(),
          ),
        ),
        GoRoute(
          path: '/signin',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const SignInScreen(),
          ),
        ),
        GoRoute(
          path: '/signup',
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
              path: '/',
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: const HomeScreen(),
              ),
            ),
            GoRoute(
              path: '/users', // Matches '/users'
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: const UsersScreen(),
              ),
            ),
            GoRoute(
              path: '/notifications', // Matches '/notifications'
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: const NotificationsScreen(),
              ),
            ),
            GoRoute(
              path: '/settings', // Matches '/settings'
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: const SettingsScreen(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CupertinoTransitionPage<T> extends CustomTransitionPage<T> {
  CupertinoTransitionPage({super.key, required super.child})
      : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.easeInOut))),
              child: child,
            );
          },
        );
}

class NoTransitionPage<T> extends CustomTransitionPage<T> {
  NoTransitionPage({super.key, required super.child})
      : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child; // No animation
          },
        );
}
