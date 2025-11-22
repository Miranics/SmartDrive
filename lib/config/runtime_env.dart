import 'package:flutter_dotenv/flutter_dotenv.dart';

class RuntimeEnv {
  const RuntimeEnv._();

  static String? _supabaseUrlOverride;
  static String? _supabaseAnonOverride;
  static String? _supabaseBucketOverride;

  static String get supabaseUrl =>
      _supabaseUrlOverride ?? _fromDotEnv('SUPABASE_URL') ?? _require('SUPABASE_URL', _supabaseUrl);
  static String get supabaseAnonKey => _supabaseAnonOverride ?? _fromDotEnv('SUPABASE_ANON_KEY') ??
      _require('SUPABASE_ANON_KEY', _supabaseAnonKey);
  static String get supabaseStorageBucket =>
      _supabaseBucketOverride ?? _fromDotEnv('SUPABASE_STORAGE_BUCKET') ??
      const String.fromEnvironment('SUPABASE_STORAGE_BUCKET', defaultValue: 'smartdrive-files');

  static const String _supabaseUrl = String.fromEnvironment('SUPABASE_URL', defaultValue: '');
  static const String _supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');

  static String? _fromDotEnv(String name) {
    final value = dotenv.maybeGet(name);
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static String _require(String name, String value) {
    if (value.isEmpty) {
      throw StateError(
        '$name is missing. Add it to your .env file or pass it via --dart-define/--dart-define-from-file.',
      );
    }
    return value;
  }

  /// Makes it possible for widget tests to bypass --dart-define requirements.
  static void overrideForTests({
    String? supabaseUrl,
    String? supabaseAnonKey,
    String? supabaseStorageBucket,
  }) {
    _supabaseUrlOverride = supabaseUrl;
    _supabaseAnonOverride = supabaseAnonKey;
    _supabaseBucketOverride = supabaseStorageBucket;
  }
}
