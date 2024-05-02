part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignIn extends AuthEvent {
  final String username;
  final String password;

  AuthSignIn({
    required this.username,
    required this.password,
  });
}

final class AuthIsUserLoggedIn extends AuthEvent {}

final class AuthLogout extends AuthEvent {}
