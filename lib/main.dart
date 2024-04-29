import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'core/common/blocs/onboarding/onboarding_bloc.dart';
import 'core/themes/theme.dart';
import 'features/auth/presentation/blocs/auth_bloc.dart';
import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<OnboardingBloc>(
          create: (context) => serviceLocator<OnboardingBloc>(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GetIt.I<GoRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightThemeMode,
      routerConfig: _router,
      title: 'Flutter Core',
    );
  }
}
