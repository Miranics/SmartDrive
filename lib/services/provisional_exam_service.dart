import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartdrive/models/provisional_question.dart';
import 'package:smartdrive/models/user_exam_stats.dart';

class ProvisionalExamService {
  ProvisionalExamService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get _questionsCollection =>
      _firestore.collection('provisional_questions');

  static CollectionReference<Map<String, dynamic>> get _userStatsCollection =>
      _firestore.collection('user_exam_stats');

  static Stream<List<ProvisionalQuestion>> streamQuestions({
    String locale = 'en',
  }) {
    return _questionsCollection
        .where('locale', isEqualTo: locale)
        .orderBy('order_index', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProvisionalQuestion.fromMap(doc.data(), doc.id))
            .toList());
  }

  static Future<List<ProvisionalQuestion>> fetchQuestions({String locale = 'en'}) async {
    final snapshot = await _questionsCollection
        .where('locale', isEqualTo: locale)
        .orderBy('order_index', descending: false)
        .get();
    return snapshot.docs
        .map((doc) => ProvisionalQuestion.fromMap(doc.data(), doc.id))
        .toList();
  }

  static Stream<int> streamQuestionCount({String locale = 'en'}) {
    return streamQuestions(locale: locale).map((questions) => questions.length);
  }

  static Stream<UserExamStats?> streamUserStats(String uid) {
    return _userStatsCollection.doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      final data = doc.data();
      if (data == null) return null;
      return UserExamStats.fromMap(doc.id, data);
    });
  }

  static Future<void> recordAttempt({
    required String uid,
    required int totalQuestions,
    required int correctAnswers,
    Map<String, Map<String, int>>? categoryBreakdown,
  }) async {
    final updates = <String, dynamic>{
      'testsTaken': FieldValue.increment(1),
      'questionsAnswered': FieldValue.increment(totalQuestions),
      'correctAnswers': FieldValue.increment(correctAnswers),
      'lastTakenAt': FieldValue.serverTimestamp(),
    };

    // Update category stats if provided
    if (categoryBreakdown != null) {
      categoryBreakdown.forEach((category, stats) {
        final questionsAnswered = stats['questionsAnswered'] ?? 0;
        final correct = stats['correctAnswers'] ?? 0;
        
        updates['categoryStats.$category.questionsAnswered'] = 
            FieldValue.increment(questionsAnswered);
        updates['categoryStats.$category.correctAnswers'] = 
            FieldValue.increment(correct);
      });
    }

    await _userStatsCollection.doc(uid).set(
      updates,
      SetOptions(merge: true),
    );
  }

  static Future<void> upsertQuestion(ProvisionalQuestion question) async {
    await _questionsCollection.doc(question.id).set(question.toMap());
  }
}
