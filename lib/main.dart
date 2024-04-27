import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/common/blocs/onboarding/onboarding_bloc.dart';
import 'core/themes/theme.dart';
import 'init_dependencies.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GetIt.I<GoRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnboardingBloc>(
          create: (context) => serviceLocator<OnboardingBloc>(),
        ),
        // Add other BlocProviders as necessary
      ],
      child: MaterialApp.router(
        theme: AppTheme.lightThemeMode,
        routerConfig: _router,
        title: 'Flutter Core',
      ),
    );
  }
}
