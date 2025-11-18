import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:smartdrive/services/auth_service.dart';
import 'package:smartdrive/services/storage_service.dart';

class StorageUploadCard extends StatefulWidget {
  const StorageUploadCard({super.key});

  @override
  State<StorageUploadCard> createState() => _StorageUploadCardState();
}

class _StorageUploadCardState extends State<StorageUploadCard> {
  bool _isUploading = false;
  String? _lastUploadedUrl;

  Future<void> _selectAndUpload() async {
    final result = await FilePicker.platform.pickFiles(withData: true);
    if (result == null) return;

    final picked = result.files.single;
    final data = picked.bytes;
    if (data == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to read file bytes.')),
      );
      return;
    }

    if (!mounted) return;
    setState(() => _isUploading = true);
    final fileName = picked.name.replaceAll(' ', '_');
    final userPrefix = AuthService.currentUser?.uid ?? 'anonymous';
    final storagePath = '$userPrefix/${DateTime.now().millisecondsSinceEpoch}_$fileName';

    try {
      final url = await StorageService.uploadBytes(
        data: data,
        path: storagePath,
      );
      if (!mounted) return;
      setState(() {
        _lastUploadedUrl = url;
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File uploaded to Supabase storage!')),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isUploading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload to Supabase Storage',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF004299),
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Store documents, permits, or progress evidence securely in Supabase.',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _isUploading ? null : _selectAndUpload,
                  icon: _isUploading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.cloud_upload_outlined),
                  label: Text(_isUploading ? 'Uploading...' : 'Select File'),
                ),
                if (_lastUploadedUrl != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Latest: $_lastUploadedUrl',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
