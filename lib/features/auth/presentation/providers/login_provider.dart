import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartdrive/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:smartdrive/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:smartdrive/features/auth/presentation/providers/auth_providers.dart';

/// Login state
class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  LoginState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

/// Login State Notifier
class LoginNotifier extends StateNotifier<LoginState> {
  final SignInWithEmailUseCase signInWithEmailUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;

  LoginNotifier({
    required this.signInWithEmailUseCase,
    required this.signInWithGoogleUseCase,
  }) : super(LoginState());

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await signInWithEmailUseCase(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
          isSuccess: false,
        );
      },
      (user) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: null,
          isSuccess: true,
        );
      },
    );
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await signInWithGoogleUseCase();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
          isSuccess: false,
        );
      },
      (user) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: null,
          isSuccess: true,
        );
      },
    );
  }

  void resetState() {
    state = LoginState();
  }
}

/// Login State Provider
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(
    signInWithEmailUseCase: ref.watch(signInWithEmailUseCaseProvider),
    signInWithGoogleUseCase: ref.watch(signInWithGoogleUseCaseProvider),
  );
});
