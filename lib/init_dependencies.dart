import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/common/blocs/onboarding/onboarding_bloc.dart';
import 'core/routes/routes.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // First, initialize SharedPreferences or any other database related services
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  // Register GoRouter
  serviceLocator
      .registerLazySingleton<GoRouter>(() => AppRouter.createRouter());

  // Now, register other services needed
  _onboarding();
}

void _onboarding() {
  serviceLocator
      .registerLazySingleton(() => OnboardingBloc(prefs: serviceLocator()));
}
