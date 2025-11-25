import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartdrive/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:smartdrive/features/auth/presentation/providers/auth_providers.dart';

/// Signup state
class SignupState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final String? successMessage;

  SignupState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
    this.successMessage,
  });

  SignupState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    String? successMessage,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      successMessage: successMessage,
    );
  }
}

/// Signup State Notifier
class SignupNotifier extends StateNotifier<SignupState> {
  final SignUpWithEmailUseCase signUpWithEmailUseCase;

  SignupNotifier({required this.signUpWithEmailUseCase}) : super(SignupState());

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await signUpWithEmailUseCase(
      email: email,
      password: password,
      displayName: displayName,
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
          successMessage: 'Account created! Please verify your email at ${user.email}',
        );
      },
    );
  }

  void resetState() {
    state = SignupState();
  }
}

/// Signup State Provider
final signupProvider = StateNotifierProvider<SignupNotifier, SignupState>((ref) {
  return SignupNotifier(
    signUpWithEmailUseCase: ref.watch(signUpWithEmailUseCaseProvider),
  );
});
