import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryStats {
  const CategoryStats({
    required this.questionsAnswered,
    required this.correctAnswers,
  });

  final int questionsAnswered;
  final int correctAnswers;

  double get accuracy {
    if (questionsAnswered == 0) return 0;
    return (correctAnswers / questionsAnswered) * 100;
  }

  factory CategoryStats.fromMap(Map<String, dynamic> data) {
    return CategoryStats(
      questionsAnswered: (data['questionsAnswered'] as num?)?.toInt() ?? 0,
      correctAnswers: (data['correctAnswers'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionsAnswered': questionsAnswered,
      'correctAnswers': correctAnswers,
    };
  }
}

class UserExamStats {
  const UserExamStats({
    required this.uid,
    required this.testsTaken,
    required this.questionsAnswered,
    required this.correctAnswers,
    this.lastTakenAt,
    this.categoryStats = const {},
  });

  final String uid;
  final int testsTaken;
  final int questionsAnswered;
  final int correctAnswers;
  final DateTime? lastTakenAt;
  final Map<String, CategoryStats> categoryStats;

  double get averageScore {
    if (questionsAnswered == 0) return 0;
    return (correctAnswers / questionsAnswered) * 100;
  }

  factory UserExamStats.fromMap(String uid, Map<String, dynamic> data) {
    final categoryStatsData = data['categoryStats'] as Map<String, dynamic>? ?? {};
    final categoryStats = categoryStatsData.map(
      (key, value) => MapEntry(
        key,
        CategoryStats.fromMap(value as Map<String, dynamic>),
      ),
    );

    return UserExamStats(
      uid: uid,
      testsTaken: (data['testsTaken'] as num?)?.toInt() ?? 0,
      questionsAnswered: (data['questionsAnswered'] as num?)?.toInt() ?? 0,
      correctAnswers: (data['correctAnswers'] as num?)?.toInt() ?? 0,
      lastTakenAt: (data['lastTakenAt'] as Timestamp?)?.toDate(),
      categoryStats: categoryStats,
    );
  }
}
