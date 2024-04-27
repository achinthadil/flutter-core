import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SharedPreferences _prefs;

  OnboardingBloc({
    required SharedPreferences prefs,
  })  : _prefs = prefs,
        super(OnboardingInitial()) {
    debugPrint('🥲 LOLL');
    on<OnboardingEvent>((_, emit) => emit(OnboardingLoadingState()));
    on<OnboardingCompleteEvent>(_handleOnboardingComplete);
  }

  void _handleOnboardingComplete(
      OnboardingCompleteEvent event, Emitter<OnboardingState> emit) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        await _prefs.setBool('isOnboardingComplete', true);
        emit(OnboardingCompleteState());
      },
    );
  }
}
