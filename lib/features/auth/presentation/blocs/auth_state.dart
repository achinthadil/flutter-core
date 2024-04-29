part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final Auth authResponse;

  AuthSuccess(this.authResponse);
}

final class AuthFailure extends AuthState {
  final String failure;

  AuthFailure(this.failure);
}
