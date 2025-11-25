import 'package:dartz/dartz.dart';
import 'package:smartdrive/core/errors/failures.dart';
import 'package:smartdrive/features/auth/domain/entities/user_entity.dart';

/// Auth Repository Interface - defines the contract for authentication
abstract class AuthRepository {
  /// Get current user stream
  Stream<UserEntity?> get authStateChanges;

  /// Get current user
  UserEntity? get currentUser;

  /// Sign in with email and password
  Future<Either<Failure, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  /// Sign in with Google
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  /// Sign out
  Future<Either<Failure, void>> signOut();

  /// Send email verification
  Future<Either<Failure, void>> sendEmailVerification();

  /// Reload current user
  Future<Either<Failure, void>> reloadCurrentUser();
}
