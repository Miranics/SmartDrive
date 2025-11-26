import 'package:flutter_test/flutter_test.dart';

// A simple mock class to simulate the Quiz Logic described in your report
class QuizGame {
  int score = 0;
  int currentIndex = 0;
  final List<String> questions = ['Q1', 'Q2', 'Q3'];

  void answerQuestion(bool isCorrect) {
    if (isCorrect) score++;
    if (currentIndex < questions.length) currentIndex++;
  }

  bool get isCompleted => currentIndex >= questions.length;
}

void main() {
  group('Quiz Logic Tests', () {
    late QuizGame game;

    setUp(() {
      game = QuizGame();
    });

    test('Score Calculation: Score increases when answer is correct', () {
      expect(game.score, 0);
      game.answerQuestion(true); // Correct answer
      expect(game.score, 1);
    });

    test('Navigation: Moves to next question after answering', () {
      expect(game.currentIndex, 0);
      game.answerQuestion(false); // Wrong answer
      expect(game.currentIndex, 1);
    });

    test('Completion: Quiz marks as completed after last question', () {
      game.answerQuestion(true); // Q1
      game.answerQuestion(true); // Q2
      game.answerQuestion(true); // Q3
      expect(game.isCompleted, true);
    });
  });
}