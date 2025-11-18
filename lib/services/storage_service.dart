import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/runtime_env.dart';

class StorageService {
  StorageService._();

  static final SupabaseClient _client = Supabase.instance.client;
  static String get _bucket => RuntimeEnv.supabaseStorageBucket;

  static Future<String> uploadBytes({
    required Uint8List data,
    required String path,
    String? bucket,
    FileOptions fileOptions = const FileOptions(cacheControl: '3600', upsert: true),
  }) async {
    final targetBucket = bucket ?? _bucket;
    final String storedPath = await _client.storage.from(targetBucket).uploadBinary(
          path,
          data,
          fileOptions: fileOptions,
        );
    return publicUrl(storedPath, bucket: targetBucket);
  }

  static String publicUrl(String path, {String? bucket}) {
    final targetBucket = bucket ?? _bucket;
    return _client.storage.from(targetBucket).getPublicUrl(path);
  }
}
