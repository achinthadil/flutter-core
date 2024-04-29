import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/common/blocs/onboarding/onboarding_bloc.dart';
import 'core/network/app_dio.dart';
import 'core/routes/routes.dart';
import 'features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/user_signin.dart';
import 'features/auth/presentation/blocs/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // First, initialize SharedPreferences or any other database related services
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  // Register GoRouter
  serviceLocator
      .registerLazySingleton<GoRouter>(() => AppRouter.createRouter());

  // Dio network client
  _dio();

  // Now, register other services needed
  _onboarding();

  _auth();
}

void _dio() {
  serviceLocator.registerLazySingleton<AppDio>(() => AppDio());
  serviceLocator
      .registerLazySingleton<Dio>(() => serviceLocator<AppDio>().getDio());
}

void _onboarding() {
  serviceLocator
      .registerLazySingleton(() => OnboardingBloc(prefs: serviceLocator()));
}

void _auth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(serviceLocator()))
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator()))
    ..registerFactory(() => UserSignIn(serviceLocator()))
    ..registerLazySingleton(() => AuthBloc(
          userSignIn: serviceLocator(),
        ));
}
