import 'package:flutter_dotenv/flutter_dotenv.dart';

class RuntimeEnv {
  const RuntimeEnv._();

  static String? _emailRedirectOverride;

  static String get emailVerificationRedirectUrl =>
      _emailRedirectOverride ?? _fromDotEnv('FIREBASE_EMAIL_REDIRECT_URL') ??
      const String.fromEnvironment(
        'FIREBASE_EMAIL_REDIRECT_URL',
        defaultValue: 'https://smartdrive-dc55d.firebaseapp.com',
      );

  static String? _fromDotEnv(String name) {
    final value = dotenv.maybeGet(name);
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  /// Makes it possible for widget tests to bypass --dart-define requirements.
  static void overrideForTests({
    String? emailRedirectUrl,
  }) {
    _emailRedirectOverride = emailRedirectUrl;
  }
}
