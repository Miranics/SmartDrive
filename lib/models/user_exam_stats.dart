import 'package:cloud_firestore/cloud_firestore.dart';

class UserExamStats {
  const UserExamStats({
    required this.uid,
    required this.testsTaken,
    required this.questionsAnswered,
    required this.correctAnswers,
    this.lastTakenAt,
  });

  final String uid;
  final int testsTaken;
  final int questionsAnswered;
  final int correctAnswers;
  final DateTime? lastTakenAt;

  double get averageScore {
    if (questionsAnswered == 0) return 0;
    return (correctAnswers / questionsAnswered) * 100;
  }

  factory UserExamStats.fromMap(String uid, Map<String, dynamic> data) {
    return UserExamStats(
      uid: uid,
      testsTaken: (data['testsTaken'] as num?)?.toInt() ?? 0,
      questionsAnswered: (data['questionsAnswered'] as num?)?.toInt() ?? 0,
      correctAnswers: (data['correctAnswers'] as num?)?.toInt() ?? 0,
      lastTakenAt: (data['lastTakenAt'] as Timestamp?)?.toDate(),
    );
  }
}
