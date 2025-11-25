import 'package:dartz/dartz.dart';
import 'package:smartdrive/core/errors/failures.dart';
import 'package:smartdrive/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.signOut();
  }
}
