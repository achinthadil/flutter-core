part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingLoadingState extends OnboardingState {}

final class OnboardingCompleteState extends OnboardingState {}
