class ServerExceptions implements Exception {
  final String message;

  const ServerExceptions(this.message);
}

class AuthException implements Exception {
  final String message;

  const AuthException(this.message);
}
