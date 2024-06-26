import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'core/network/app_dio.dart';
import 'core/routes/routes.dart';
import 'features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart';
import 'features/auth/data/data_sources/remote/retrofit/auth_retrofit_client.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/current_user.dart';
import 'features/auth/domain/usecases/user_logout.dart';
import 'features/auth/domain/usecases/user_signin.dart';
import 'features/auth/presentation/blocs/auth_bloc.dart';
import 'features/home/data/data_sources/remote_data_sources/home_remote_data_source.dart';
import 'features/home/data/data_sources/remote_data_sources/home_remote_data_source_impl.dart';
import 'features/home/data/data_sources/remote_data_sources/retrofit/home_retrofit_client.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_products.dart';
import 'features/home/presentation/blocs/home_bloc.dart';
import 'features/main/presentation/blocs/main_bloc.dart';
import 'features/onboarding/presentation/blocs/onboarding_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // First, initialize SharedPreferences or any other database related services
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  // Register GoRouter
  serviceLocator
      .registerLazySingleton<GoRouter>(() => AppRouter.createRouter());

  // Package info  plus
  final packageInfo = await PackageInfo.fromPlatform();
  serviceLocator.registerLazySingleton(() => packageInfo);

  // Dio network client
  _dio();

  // Now, register other services needed
  _onboarding();

  _coreDependencies();

  _auth();

  _main();

  _home();
}

void _coreDependencies() {
  serviceLocator.registerLazySingleton(() => AppUserCubit());
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
    ..registerFactory<AuthRetrofitClient>(
        () => AuthRetrofitClient(serviceLocator()))
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
        authRetrofitClient: serviceLocator(), prefs: serviceLocator()))
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator()))
    ..registerFactory(() => UserSignIn(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerFactory(() => UserLogout(serviceLocator()))
    ..registerLazySingleton(() => AuthBloc(
          userSignIn: serviceLocator(),
          appUserCubit: serviceLocator(),
          currentUser: serviceLocator(),
          userLogout: serviceLocator(),
        ));
}

void _main() {
  serviceLocator.registerLazySingleton<MainBloc>(() => MainBloc());
}

void _home() {
  serviceLocator
    ..registerFactory<HomeRetrofitClient>(
        () => HomeRetrofitClient(serviceLocator()))
    ..registerFactory<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(homeRetrofitClient: serviceLocator()))
    ..registerFactory<HomeRepository>(
        () => HomeRepositoryImpl(serviceLocator()))
    ..registerFactory(() => GetProducts(serviceLocator()))
    ..registerLazySingleton(() => HomeBloc(getProducts: serviceLocator()));
}
