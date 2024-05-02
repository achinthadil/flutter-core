import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../core/constants/image_paths.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/themes/app_pallete.dart';
import '../blocs/onboarding_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleteState) {
            context.go(CoreRoutePaths.signin);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              //! background image
              SvgPicture.asset(
                height: double.infinity,
                CoreImagePaths.coreOnboarding,
                fit: BoxFit.fill,
              ),
              //! gradient
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppPallete.transparentColor,
                      AppPallete.blackColor.withOpacity(1.0),
                    ],
                  ),
                ),
              ),
              //! column
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //! heading
                    FadeIn(
                      duration: const Duration(seconds: 3),
                      child: Text(
                        'Lorem Ipsum',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: AppPallete.whiteColor,
                              fontSize: 35,
                            ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //! sub heading
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: FadeIn(
                        duration: const Duration(seconds: 1),
                        child: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppPallete.whiteColor,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    //! button
                    (state is OnboardingLoadingState)
                        ? const Loader()
                        : FadeInUp(
                            duration: const Duration(seconds: 1),
                            child: ElevatedButton(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style
                                  ?.copyWith(
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(Size(
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                            50)),
                                  ),
                              onPressed: () {
                                context
                                    .read<OnboardingBloc>()
                                    .add(OnboardingCompleteEvent());
                              },
                              child: Text(
                                'Get Started',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: AppPallete.whiteColor),
                              ),
                            ),
                          ),
                    const SizedBox(height: 60),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
