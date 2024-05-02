import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/auth.dart';
import '../../domain/usecases/current_user.dart';
import '../../domain/usecases/user_logout.dart';
import '../../domain/usecases/user_signin.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final UserLogout _userLogout;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required UserLogout userLogout,
    required AppUserCubit appUserCubit,
  })  : _userSignIn = userSignIn,
        _currentUser = currentUser,
        _userLogout = userLogout,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthLogout>(_onAuthLogout);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
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

  void _onAuthLogout(AuthLogout logout, Emitter<AuthState> emit) async {
    final res = await _userLogout(NoParams());
    res.fold((l) => AuthFailure(l.message), (r) => _emitLogoutSuccess(emit));
  }

  void _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold(
        (l) => emit(AuthFailure(l.message)), (r) => _emitAuthSuccess(r, emit));
  }

  void _emitAuthSuccess(Auth authResponse, Emitter<AuthState> emit) async {
    _appUserCubit.updateUser(authResponse);
    emit(AuthSuccess(authResponse));
  }

  void _emitLogoutSuccess(Emitter<AuthState> emit) {
    _appUserCubit.updateUser(null);
    emit(AuthInitial());
  }
}
