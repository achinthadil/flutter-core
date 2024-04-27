part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {}

class OnboardingCompleteEvent extends OnboardingEvent {}
