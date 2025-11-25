import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smartdrive/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  final firestore = FirebaseFirestore.instance;
  final questionsRef = firestore.collection('provisional_questions');
  
  final snapshot = await questionsRef.get();
  
  print('Found ${snapshot.docs.length} questions');
  
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
    
    await doc.reference.update({'category': category});
    count++;
    print('Updated $count: ${doc.id} -> $category');
  }
  
  print('✅ Done! Updated $count questions');
}
