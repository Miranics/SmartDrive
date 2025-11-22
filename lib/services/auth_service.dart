import 'package:firebase_auth/firebase_auth.dart';

class EmailNotVerifiedException implements Exception {
  const EmailNotVerifiedException([this.message]);
  final String? message;

  @override
  String toString() => message ?? 'Email is not verified yet';
}

class AuthService {
  AuthService._();

  static FirebaseAuth get _auth => FirebaseAuth.instance;

  static Stream<User?> get authChanges => _auth.authStateChanges();

  static User? get currentUser => _auth.currentUser;

  static Future<UserCredential> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (displayName != null && displayName.isNotEmpty) {
      await credential.user?.updateDisplayName(displayName);
    }

    await credential.user?.sendEmailVerification();

    return credential;
  }

  static Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    await user?.reload();
    final isVerified = user?.emailVerified ?? false;

    if (!isVerified) {
      await user?.sendEmailVerification();
      await _auth.signOut();
      throw EmailNotVerifiedException(
        'Please verify your email. We just sent a confirmation link to $email.',
      );
    }

    return credential;
  }

  static Future<void> signOut() => _auth.signOut();
}
