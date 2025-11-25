import 'package:dartz/dartz.dart';
import 'package:smartdrive/core/errors/failures.dart';
import 'package:smartdrive/features/auth/domain/repositories/auth_repository.dart';

class SendEmailVerificationUseCase {
  final AuthRepository repository;

  SendEmailVerificationUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.sendEmailVerification();
  }
}
