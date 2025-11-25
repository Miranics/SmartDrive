import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartdrive/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:smartdrive/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:smartdrive/features/auth/domain/repositories/auth_repository.dart';
import 'package:smartdrive/features/auth/domain/usecases/send_email_verification.dart';
import 'package:smartdrive/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:smartdrive/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:smartdrive/features/auth/domain/usecases/sign_out.dart';
import 'package:smartdrive/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:smartdrive/features/auth/domain/entities/user_entity.dart';

// ============ DATA SOURCE PROVIDERS ============

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    googleSignIn: ref.watch(googleSignInProvider),
  );
});

// ============ REPOSITORY PROVIDER ============

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
  );
});

// ============ USE CASE PROVIDERS ============

final signInWithEmailUseCaseProvider = Provider<SignInWithEmailUseCase>((ref) {
  return SignInWithEmailUseCase(ref.watch(authRepositoryProvider));
});

final signUpWithEmailUseCaseProvider = Provider<SignUpWithEmailUseCase>((ref) {
  return SignUpWithEmailUseCase(ref.watch(authRepositoryProvider));
});

final signInWithGoogleUseCaseProvider = Provider<SignInWithGoogleUseCase>((ref) {
  return SignInWithGoogleUseCase(ref.watch(authRepositoryProvider));
});

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
});

final sendEmailVerificationUseCaseProvider = Provider<SendEmailVerificationUseCase>((ref) {
  return SendEmailVerificationUseCase(ref.watch(authRepositoryProvider));
});

// ============ AUTH STATE PROVIDER ============

/// Provides the current authentication state as a stream
final authStateProvider = StreamProvider<UserEntity?>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges;
});

/// Provides the current user synchronously (can be null)
final currentUserProvider = Provider<UserEntity?>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.currentUser;
});
