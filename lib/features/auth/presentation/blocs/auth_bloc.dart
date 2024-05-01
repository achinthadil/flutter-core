import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../domain/entities/auth.dart';
import '../../domain/usecases/user_signin.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignIn _userSignIn;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignIn userSignIn,
    required AppUserCubit appUserCubit,
  })  : _userSignIn = userSignIn,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignIn>(_onAuthSignIn);
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final res = await _userSignIn(UserSignInParams(
      loginCredential: jsonEncode(
        {
          'username': event.username,
          'password': event.password,
        },
      ),
    ));

    res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => _emitAuthSuccess(r, emit));
  }

  void _emitAuthSuccess(Auth authResponse, Emitter<AuthState> emit) async {
    _appUserCubit.updateAuthResponse(authResponse);
    emit(AuthSuccess(authResponse));
  }
}
