/// Base exception class
class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

/// Server/Firebase exceptions
class ServerException extends AppException {
  const ServerException(super.message);
}

/// Authentication exceptions
class AuthException extends AppException {
  const AuthException(super.message);
}

/// Cache exceptions
class CacheException extends AppException {
  const CacheException(super.message);
}

/// Network exceptions
class NetworkException extends AppException {
  const NetworkException(super.message);
}
