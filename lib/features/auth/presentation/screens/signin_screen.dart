import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/common/widgets/loader.dart';
import '../../../../core/constants/icon_paths.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/themes/app_pallete.dart';
import '../../../../core/utils/show_alert.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../blocs/auth_bloc.dart';
import '../widgets/auth_field.dart';
import '../widgets/image_icon_button.dart';
import '../widgets/primary_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signinFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showAlertDialog(
                context: context,
                title: 'Error',
                content: 'Please check your credentials and try again.',
              );
            }
          },
        ),
        BlocListener<AppUserCubit, AppUserState>(
          listener: (context, state) {
            if (state is AppUserLoggedIn) {
              showSnackBar(context, "Successfully signed in!");
              context.go(CoreRoutePaths.home);
            }
          },
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FadeIn(
                duration: const Duration(milliseconds: 1500),
                child: Form(
                  key: _signinFormKey,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const SizedBox(height: 50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Hello,',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              'Welcome Back!',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        AuthField(
                          controller: _emailController,
                          hintText: 'Username',
                          isObscureText: false,
                        ),
                        const SizedBox(height: 20),
                        AuthField(
                          controller: _passwordController,
                          hintText: 'Password',
                          isObscureText: true,
                        ),
                        const SizedBox(height: 5),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppPallete.orangeColor),
                            )),
                        const SizedBox(height: 20),
                        PrimaryButton(
                            title: 'Sign In',
                            onPressed: () {
                              if (_signinFormKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      AuthSignIn(
                                        username: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      ),
                                    );
                              }
                            }),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: AppPallete.greyColor.withOpacity(0.3),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Or Sign In With',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppPallete.greyColor
                                            .withOpacity(0.5),
                                        fontSize: 12),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: AppPallete.greyColor.withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIconButton(
                              onPressed: () {},
                              icon: CoreIconPaths.googleIcon,
                            ),
                            const SizedBox(width: 20),
                            ImageIconButton(
                              onPressed: () {},
                              icon: CoreIconPaths.facebookIcon,
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an account?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 3),
                            GestureDetector(
                              onTap: () => context.go(CoreRoutePaths.signup),
                              child: Text(
                                'Sign up',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppPallete.orangeColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}
