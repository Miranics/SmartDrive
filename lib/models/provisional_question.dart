class ProvisionalQuestion {
  const ProvisionalQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.locale = 'en',
    this.orderIndex,
  });

  final String id;
  final String question;
  final Map<String, String> options;
  final String correctAnswer;
  final String locale;
  final int? orderIndex;

  factory ProvisionalQuestion.fromMap(Map<String, dynamic> map, String id) {
    final optionsRaw = map['options'] as Map<String, dynamic>? ?? {};
    final options = optionsRaw.map((key, value) => MapEntry(key, value.toString()));

    return ProvisionalQuestion(
      id: id,
      question: map['question'] as String? ?? '',
      options: options,
      correctAnswer: map['correct_answer'] as String? ?? '',
      locale: map['locale'] as String? ?? 'en',
      orderIndex: (map['order_index'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correct_answer': correctAnswer,
      'locale': locale,
      if (orderIndex != null) 'order_index': orderIndex,
    };
  }

  bool isCorrect(String answerKey) {
    return answerKey.toLowerCase().trim() == correctAnswer.toLowerCase().trim();
  }

  List<MapEntry<String, String>> get sortedOptions {
    final entries = options.entries.toList();
    entries.sort((a, b) => a.key.compareTo(b.key));
    return entries;
  }
}