import 'package:dartz/dartz.dart';
import 'package:smartdrive/core/errors/failures.dart';
import 'package:smartdrive/features/auth/domain/entities/user_entity.dart';
import 'package:smartdrive/features/auth/domain/repositories/auth_repository.dart';

class SignUpWithEmailUseCase {
  final AuthRepository repository;

  SignUpWithEmailUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    String? displayName,
  }) {
    return repository.signUpWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
