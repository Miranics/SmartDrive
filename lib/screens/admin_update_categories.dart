import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUpdateCategories extends StatefulWidget {
  const AdminUpdateCategories({super.key});

  @override
  State<AdminUpdateCategories> createState() => _AdminUpdateCategoriesState();
}

class _AdminUpdateCategoriesState extends State<AdminUpdateCategories> {
  bool _isUpdating = false;
  String _status = '';
  int _updated = 0;

  Future<void> _updateAllQuestions() async {
    setState(() {
      _isUpdating = true;
      _status = 'Fetching questions...';
      _updated = 0;
    });

    try {
      final firestore = FirebaseFirestore.instance;
      final snapshot =
          await firestore.collection('provisional_questions').get();

      setState(() =>
          _status = 'Found ${snapshot.docs.length} questions. Updating...');

      int count = 0;
      for (var doc in snapshot.docs) {
        String category;
        if (count % 3 == 0) {
          category = 'Traffic Signs';
        } else if (count % 3 == 1) {
          category = 'Road Safety';
        } else {
          category = 'Vehicle Control';
        }

        print('Updating ${doc.id} with category: $category');
        await doc.reference.update({'category': category});
        count++;
        setState(() {
          _updated = count;
          _status = 'Updated $count/${snapshot.docs.length} - Last: $category';
        });
      }

      setState(() {
        _isUpdating = false;
        _status = '✅ Done! Updated $count questions';
      });
    } catch (e) {
      setState(() {
        _isUpdating = false;
        _status = '❌ Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Categories')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Add Categories to Questions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'This will add category field to all questions',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (_status.isNotEmpty) ...[
                Text(_status, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
              ],
              ElevatedButton(
                onPressed: _isUpdating ? null : _updateAllQuestions,
                child: _isUpdating
                    ? const CircularProgressIndicator()
                    : const Text('Update All Questions'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
