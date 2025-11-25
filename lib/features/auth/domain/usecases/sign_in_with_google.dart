import 'package:dartz/dartz.dart';
import 'package:smartdrive/core/errors/failures.dart';
import 'package:smartdrive/features/auth/domain/entities/user_entity.dart';
import 'package:smartdrive/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;

  SignInWithGoogleUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call() {
    return repository.signInWithGoogle();
  }
}
