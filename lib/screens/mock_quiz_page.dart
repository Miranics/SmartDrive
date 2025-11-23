import 'package:flutter/material.dart';
import 'package:smartdrive/widgets/contact_us_card.dart';
import 'package:smartdrive/widgets/practice_quiz_card.dart';
import 'package:smartdrive/widgets/button_component.dart';

class MockQuizPage extends StatefulWidget {
  final int timerMinutes;
  const MockQuizPage({Key? key, this.timerMinutes = 20}) : super(key: key);

  @override
  State<MockQuizPage> createState() => _MockQuizPageState();
}

class _MockQuizPageState extends State<MockQuizPage> {
  late int _remainingSeconds;
  late PageController _pageController;
  int _currentQuestion = 0;
  int _score = 0;
  bool _quizFinished = false;
  late List<Map<String, dynamic>> _questions;
  late List<int?> _userAnswers;
  late final int _totalQuestions;
  late final int _passMark;
  late final int _timerMinutes;
  @override
  void initState() {
    super.initState();
    _timerMinutes = widget.timerMinutes;
    _remainingSeconds = _timerMinutes * 60;
    _pageController = PageController();
    _questions = [
      {
        'question':
            'What is the maximum speed limit in residential areas in Rwanda?',
        'options': ['60 km/h', '30 km/h', '50 km/h', '40 km/h'],
        'answer': 1,
      },
      {
        'question': 'What does a red traffic light mean?',
        'options': ['Go', 'Stop', 'Slow down', 'Yield'],
        'answer': 1,
      },
      // Add more questions as needed
    ];
    _totalQuestions = _questions.length;
    _userAnswers = List<int?>.filled(_totalQuestions, null);
    _passMark = 60; // percent
    _startTimer();
  }

  void _startTimer() {
    Future.doWhile(() async {
      if (_remainingSeconds > 0 && !_quizFinished) {
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) setState(() => _remainingSeconds--);
        return true;
      }
      if (_remainingSeconds == 0 && !_quizFinished) {
        _finishQuiz();
      }
      return false;
    });
  }

  void _selectAnswer(int selectedIdx) {
    setState(() {
      _userAnswers[_currentQuestion] = selectedIdx;
    });
  }

  void _nextQuestion() {
    if (_currentQuestion < _totalQuestions - 1) {
      setState(() {
        _currentQuestion++;
      });
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() {
    setState(() {
      _quizFinished = true;
      _score = 0;
      for (int i = 0; i < _totalQuestions; i++) {
        if (_userAnswers[i] == _questions[i]['answer']) {
          _score++;
        }
      }
    });
    // Navigate to results page (replace with your results screen route)
    Navigator.pushReplacementNamed(context, '/progress', arguments: {
      'score': _score,
      'total': _totalQuestions,
      'passMark': _passMark,
    });
  }

  String _formatTime(int seconds) {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mock Test'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timer and Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time Left: ${_formatTime(_remainingSeconds)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Q: ${_currentQuestion + 1}/$_totalQuestions',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _totalQuestions,
                itemBuilder: (context, index) {
                  final q = _questions[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PracticeQuizCard(
                        questionText: q['question'],
                        options: List<String>.from(q['options']),
                        onOptionSelected: (optIdx) {
                          _selectAnswer(optIdx);
                        },
                      ),
                      const SizedBox(height: 8),
                      ButtonComponent(
                        text: index == _totalQuestions - 1
                            ? 'Finish'
                            : 'Next Question',
                        type: ButtonType.secondary,
                        onPressed: _userAnswers[index] != null
                            ? () {
                                if (index == _totalQuestions - 1) {
                                  _finishQuiz();
                                } else {
                                  setState(() {
                                    _currentQuestion++;
                                  });
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              }
                            : null,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const ContactUsCard(),
          ],
        ),
      ),
    );
  }
}
