import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartdrive/config/runtime_env.dart';
import 'package:smartdrive/core/errors/exceptions.dart';
import 'package:smartdrive/features/auth/data/models/user_model.dart';

/// Firebase Authentication Remote Data Source
abstract class AuthRemoteDataSource {
  Stream<UserModel?> get authStateChanges;
  UserModel? get currentUser;
  
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });
  
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });
  
  Future<UserModel> signInWithGoogle();
  
  Future<void> signOut();
  
  Future<void> sendEmailVerification();
  
  Future<void> reloadCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Stream<UserModel?> get authStateChanges {
    return firebaseAuth.userChanges().map((user) {
      return user != null ? UserModel.fromFirebaseUser(user) : null;
    });
  }

  @override
  UserModel? get currentUser {
    final user = firebaseAuth.currentUser;
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user == null) {
        throw const AuthException('Sign in failed - no user returned');
      }
      
      await credential.user!.reload();
      final updatedUser = firebaseAuth.currentUser;
      
      return UserModel.fromFirebaseUser(updatedUser!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Authentication failed');
    } catch (e) {
      throw AuthException('Unexpected error: $e');
    }
  }

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const AuthException('Sign up failed - no user returned');
      }

      if (displayName != null && displayName.isNotEmpty) {
        await credential.user!.updateDisplayName(displayName);
      }

      await _sendVerificationEmail(credential.user!);

      return UserModel.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Registration failed');
    } catch (e) {
      throw AuthException('Unexpected error: $e');
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw const AuthException('Google sign in was cancelled');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw const AuthException('Google sign in failed - no user returned');
      }

      return UserModel.fromFirebaseUser(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Google sign in failed');
    } catch (e) {
      throw AuthException('Unexpected error during Google sign in: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      // Sign out from Google if signed in
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
      
      // Sign out from Firebase
      await firebaseAuth.signOut();
    } catch (e) {
      throw AuthException('Sign out failed: $e');
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw const AuthException('No authenticated user found');
      }

      if (user.emailVerified) {
        return; // Already verified
      }

      final settings = ActionCodeSettings(
        url: RuntimeEnv.emailVerificationRedirectUrl,
        handleCodeInApp: false,
        androidPackageName: 'com.example.smartdrive',
        androidInstallApp: true,
        androidMinimumVersion: '21',
        iOSBundleId: 'com.example.smartdrive',
      );

      await user.sendEmailVerification(settings);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Failed to send verification email');
    } catch (e) {
      throw AuthException('Unexpected error: $e');
    }
  }

  @override
  Future<void> reloadCurrentUser() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        await user.reload();
      }
    } catch (e) {
      throw AuthException('Failed to reload user: $e');
    }
  }

  Future<void> _sendVerificationEmail(User user) async {
    final settings = ActionCodeSettings(
      url: RuntimeEnv.emailVerificationRedirectUrl,
      handleCodeInApp: false,
      androidPackageName: 'com.example.smartdrive',
      androidInstallApp: true,
      androidMinimumVersion: '21',
      iOSBundleId: 'com.example.smartdrive',
    );

    await user.sendEmailVerification(settings);
  }
}
