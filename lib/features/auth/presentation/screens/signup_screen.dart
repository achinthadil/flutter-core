import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/icon_paths.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/themes/app_pallete.dart';
import '../widgets/auth_field.dart';
import '../widgets/image_icon_button.dart';
import '../widgets/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: FadeIn(
            duration: const Duration(milliseconds: 1500),
            child: Form(
              key: _signupFormKey,
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
                          'Create an account',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          'Let’s help you set up your account, \nit won’t take long.',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    AuthField(
                      controller: _nameController,
                      hintText: 'Name',
                      isObscureText: false,
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    AuthField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      isObscureText: true,
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                        title: 'Sign Up',
                        onPressed: () {
                          _signupFormKey.currentState!.validate();
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Or Sign In With',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color:
                                        AppPallete.greyColor.withOpacity(0.5),
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
                          'Already a member?',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 3),
                        GestureDetector(
                          onTap: () => context.go(CoreRoutePaths.signin),
                          child: Text(
                            'Sign In',
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
      ),
    );
  }
}
