import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartdrive/config/runtime_env.dart';

class AuthService {
  AuthService._();

  static FirebaseAuth get _auth => FirebaseAuth.instance;
  static DateTime? _lastVerificationEmailSent;

  static Stream<User?> get authChanges => _auth.userChanges();

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

    await _sendEmailVerification(credential.user);

    return credential;
  }

  static Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    await credential.user?.reload();
    return credential;
  }

  static Future<void> signOut() => _auth.signOut();

  static Future<void> sendVerificationEmail({bool force = false}) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('Cannot send verification email without an authenticated user.');
    }
    if (user.emailVerified && !force) return;

    // Prevent sending emails more than once per minute
    if (_lastVerificationEmailSent != null && !force) {
      final timeSinceLastEmail = DateTime.now().difference(_lastVerificationEmailSent!);
      if (timeSinceLastEmail.inSeconds < 60) {
        return; // Skip sending if less than 60 seconds since last email
      }
    }

    final settings = _buildActionCodeSettings();
    await user.sendEmailVerification(settings);
    _lastVerificationEmailSent = DateTime.now();
  }

  static Future<void> reloadCurrentUser() async {
    await _auth.currentUser?.reload();
  }

  static Future<void> _sendEmailVerification(User? user) async {
    if (user == null) return;
    final settings = _buildActionCodeSettings();
    await user.sendEmailVerification(settings);
  }

  static ActionCodeSettings _buildActionCodeSettings() {
    return ActionCodeSettings(
      url: RuntimeEnv.emailVerificationRedirectUrl,
      handleCodeInApp: false,
      androidPackageName: 'com.example.smartdrive',
      androidInstallApp: true,
      androidMinimumVersion: '21',
      iOSBundleId: 'com.example.smartdrive',
    );
  }
}
