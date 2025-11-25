import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Server/Firebase related failures
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Authentication failures
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Cache/Local storage failures
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Network failures
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
