import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartdrive/constants/app_colors.dart';
import 'package:smartdrive/data/mock_test_data.dart';
import 'package:smartdrive/screens/mock_test_scores.dart';

// State providers
final currentQuestionIndexProvider = StateProvider<int>((ref) => 0);
final selectedAnswersProvider = StateProvider<Map<int, String>>((ref) => {});
final secondsRemainingProvider = StateProvider<int>((ref) => 1200); // 20 minutes
final timeUpProvider = StateProvider<bool>((ref) => false);

// Timer provider
final timerProvider = Provider.autoDispose<void>((ref) {
  final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    final secondsRemaining = ref.read(secondsRemainingProvider);
    if (secondsRemaining > 0) {
      ref.read(secondsRemainingProvider.notifier).state = secondsRemaining - 1;
    } else {
      ref.read(timeUpProvider.notifier).state = true;
      timer.cancel();
    }
  });

  ref.onDispose(() {
    timer.cancel();
  });
});

class MockTestQuestionsPage extends ConsumerStatefulWidget {
  const MockTestQuestionsPage({super.key});

  @override
  ConsumerState<MockTestQuestionsPage> createState() => _MockTestQuestionsPageState();
}

class _MockTestQuestionsPageState extends ConsumerState<MockTestQuestionsPage> {
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    // Initialize the timer
    Future.microtask(() => ref.read(timerProvider));
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _selectAnswer(String answer) {
    final timeUp = ref.read(timeUpProvider);
    if (!timeUp) {
      final currentIndex = ref.read(currentQuestionIndexProvider);
      final selectedAnswers = ref.read(selectedAnswersProvider);
      ref.read(selectedAnswersProvider.notifier).state = {
        ...selectedAnswers,
        currentIndex: answer,
      };
    }
  }

  void _nextQuestion() {
    final currentIndex = ref.read(currentQuestionIndexProvider);
    if (currentIndex < mockTestQuestions.length - 1) {
      ref.read(currentQuestionIndexProvider.notifier).state = currentIndex + 1;
    }
  }

  void _previousQuestion() {
    final currentIndex = ref.read(currentQuestionIndexProvider);
    if (currentIndex > 0) {
      ref.read(currentQuestionIndexProvider.notifier).state = currentIndex - 1;
    }
  }

  void _submitTest() {
    final selectedAnswers = ref.read(selectedAnswersProvider);
    final secondsRemaining = ref.read(secondsRemainingProvider);
    
    // Calculate score
    int correctAnswers = 0;
    for (int i = 0; i < mockTestQuestions.length; i++) {
      if (selectedAnswers[i] == mockTestQuestions[i].correctAnswer) {
        correctAnswers++;
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MockTestScoresPage(
          correctAnswers: correctAnswers,
          totalQuestions: mockTestQuestions.length,
          timeUsed: 1200 - secondsRemaining,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestionIndex = ref.watch(currentQuestionIndexProvider);
    final selectedAnswers = ref.watch(selectedAnswersProvider);
    final secondsRemaining = ref.watch(secondsRemainingProvider);
    final timeUp = ref.watch(timeUpProvider);

    // Show time up dialog once
    if (timeUp && !_dialogShown) {
      _dialogShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Time\'s Up!'),
            content: const Text(
              'Your time has run out. Please submit your test now.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }

    final question = mockTestQuestions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / mockTestQuestions.length;

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit Test?'),
            content: const Text(
              'Are you sure you want to exit? Your progress will be lost.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Exit'),
              ),
            ],
          ),
        );
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Timer and Progress Bar
              Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.white,
                child: Column(
                  children: [
                    // Timer
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: timeUp ? AppColors.red : AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            color: AppColors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _formatTime(secondsRemaining),
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 8,
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: AppColors.lightBlue,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Question ${currentQuestionIndex + 1} of ${mockTestQuestions.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Question and Options
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Question
                      Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      
                      // Options
                      ...question.options.map((option) {
                        final isSelected = selectedAnswers[currentQuestionIndex] == option;
                        return GestureDetector(
                          onTap: timeUp ? null : () => _selectAnswer(option),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? AppColors.lightBlue 
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected 
                                    ? AppColors.primaryBlue 
                                    : AppColors.lightGray,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textPrimary,
                                fontWeight: isSelected 
                                    ? FontWeight.w600 
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              
              // Navigation Buttons
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Previous Button
                    if (currentQuestionIndex > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _previousQuestion,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(
                              color: AppColors.primaryBlue,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Previous',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                      ),
                    
                    if (currentQuestionIndex > 0)
                      const SizedBox(width: 16),
                    
                    // Next/Submit Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: currentQuestionIndex == mockTestQuestions.length - 1
                            ? _submitTest
                            : _nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          currentQuestionIndex == mockTestQuestions.length - 1
                              ? 'Submit'
                              : 'Next',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}