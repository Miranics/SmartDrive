class RuntimeEnv {
  const RuntimeEnv._();

  static String? _supabaseUrlOverride;
  static String? _supabaseAnonOverride;
  static String? _supabaseBucketOverride;

  static String get supabaseUrl => _supabaseUrlOverride ?? _require('SUPABASE_URL', _supabaseUrl);
  static String get supabaseAnonKey =>
    _supabaseAnonOverride ?? _require('SUPABASE_ANON_KEY', _supabaseAnonKey);
  static String get supabaseStorageBucket => _supabaseBucketOverride ??
    const String.fromEnvironment('SUPABASE_STORAGE_BUCKET', defaultValue: 'smartdrive-files');

  static const String _supabaseUrl = String.fromEnvironment('SUPABASE_URL', defaultValue: '');
  static const String _supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');

  static String _require(String name, String value) {
    if (value.isEmpty) {
      throw StateError(
        '$name is missing. Pass it via --dart-define or --dart-define-from-file.',
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
