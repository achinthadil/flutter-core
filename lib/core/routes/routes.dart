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
    final sharedPreferences = serviceLocator<SharedPreferences>();
    bool isOnboardingComplete =
        sharedPreferences.getBool(CoreConstants.isOnboardingComplete) ?? false;
    String? userToken = sharedPreferences.getString(CoreConstants.userToken);

    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: isOnboardingComplete
          ? (userToken != null ? '/home' : '/signin')
          : '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/signin',
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignUpScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) => MainScreen(child: child),
          routes: [
            GoRoute(
              path: '/home', // Ensures the HomeScreen is available at '/home'
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/users', // Matches '/users'
              builder: (context, state) => const UsersScreen(),
            ),
            GoRoute(
              path: '/notifications', // Matches '/notifications'
              builder: (context, state) => const NotificationsScreen(),
            ),
            GoRoute(
              path: '/settings', // Matches '/settings'
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    );
  }
}
