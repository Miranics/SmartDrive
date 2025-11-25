import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartdrive/constants/app_colors.dart';
import 'package:smartdrive/screens/mock_test_scores.dart';
import 'package:smartdrive/models/provisional_question.dart';
import 'package:smartdrive/services/provisional_exam_service.dart';

// Questions provider - fetches from Firestore
final mockTestQuestionsProvider = FutureProvider<List<ProvisionalQuestion>>((ref) async {
  final questions = await ProvisionalExamService.fetchQuestions(locale: 'en');
  // Get random 20 questions for mock test
  if (questions.length > 20) {
    questions.shuffle();
    return questions.take(20).toList();
  }
  return questions;
});

// State providers
final currentQuestionIndexProvider = StateProvider<int>((ref) => 0);
final selectedAnswersProvider = StateProvider<Map<int, String>>((ref) => {});
final secondsRemainingProvider = StateProvider<int>((ref) => 1200); // 20 minutes
final timeUpProvider = StateProvider<bool>((ref) => false);

class MockTestQuestionsPage extends ConsumerStatefulWidget {
  const MockTestQuestionsPage({super.key});

  @override
  ConsumerState<MockTestQuestionsPage> createState() => _MockTestQuestionsPageState();
}

class _MockTestQuestionsPageState extends ConsumerState<MockTestQuestionsPage> {
  bool _dialogShown = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      final secondsRemaining = ref.read(secondsRemainingProvider);
      if (secondsRemaining > 0) {
        ref.read(secondsRemainingProvider.notifier).state = secondsRemaining - 1;
      } else {
        ref.read(timeUpProvider.notifier).state = true;
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _selectAnswer(String answerKey) {
    final timeUp = ref.read(timeUpProvider);
    if (!timeUp) {
      final currentIndex = ref.read(currentQuestionIndexProvider);
      final selectedAnswers = ref.read(selectedAnswersProvider);
      ref.read(selectedAnswersProvider.notifier).state = {
        ...selectedAnswers,
        currentIndex: answerKey,
      };
    }
  }

  void _nextQuestion(int totalQuestions) {
    final currentIndex = ref.read(currentQuestionIndexProvider);
    if (currentIndex < totalQuestions - 1) {
      ref.read(currentQuestionIndexProvider.notifier).state = currentIndex + 1;
    }
  }

  void _previousQuestion() {
    final currentIndex = ref.read(currentQuestionIndexProvider);
    if (currentIndex > 0) {
      ref.read(currentQuestionIndexProvider.notifier).state = currentIndex - 1;
    }
  }

  void _submitTest(List<ProvisionalQuestion> questions) {
    final selectedAnswers = ref.read(selectedAnswersProvider);
    final secondsRemaining = ref.read(secondsRemainingProvider);
    
    // Calculate score
    int correctAnswers = 0;
    for (int i = 0; i < questions.length; i++) {
      final selectedKey = selectedAnswers[i];
      if (selectedKey != null && questions[i].isCorrect(selectedKey)) {
        correctAnswers++;
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MockTestScoresPage(
          correctAnswers: correctAnswers,
          totalQuestions: questions.length,
          timeUsed: 1200 - secondsRemaining,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionsAsync = ref.watch(mockTestQuestionsProvider);
    final currentQuestionIndex = ref.watch(currentQuestionIndexProvider);
    final selectedAnswers = ref.watch(selectedAnswersProvider);
    final secondsRemaining = ref.watch(secondsRemainingProvider);
    final timeUp = ref.watch(timeUpProvider);

    return questionsAsync.when(
      loading: () => Scaffold(
        backgroundColor: AppColors.white,
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: AppColors.primaryBlue,
              ),
              SizedBox(height: 16),
              Text(
                'Loading questions...',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
      error: (error, stack) {
        // Better error handling
        String errorMessage = 'An error occurred while loading questions.';
        
        if (error.toString().contains('permission-denied')) {
          errorMessage = 'Permission denied. Please check your Firestore security rules.';
        } else if (error.toString().contains('unavailable')) {
          errorMessage = 'Service unavailable. Please check your internet connection.';
        }
        
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.red,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Failed to load questions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    errorMessage,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text(
                      'Go Back',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      data: (questions) {
        if (questions.isEmpty) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.quiz_outlined,
                      color: AppColors.primaryBlue,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No questions available',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: const Text(
                        'Go Back',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // Auto-submit when time runs out
        if (timeUp && !_dialogShown) {
          _dialogShown = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _submitTest(questions);
            }
          });
        }

        final question = questions[currentQuestionIndex];
        final progress = (currentQuestionIndex + 1) / questions.length;
        final sortedOptions = question.sortedOptions;

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Quit Button
                            IconButton(
                              onPressed: () async {
                                final shouldQuit = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Quit Test?'),
                                    content: const Text(
                                      'Are you sure you want to quit? Your progress will be lost.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, true),
                                        child: const Text('Quit'),
                                      ),
                                    ],
                                  ),
                                );
                                if (shouldQuit == true && mounted) {
                                  Navigator.pop(context);
                                }
                              },
                              icon: const Icon(Icons.close, color: AppColors.red),
                            ),
                            // Timer
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: secondsRemaining <= 180 ? AppColors.red : AppColors.primaryBlue,
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
                            const SizedBox(width: 48),
                          ],
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
                          'Question ${currentQuestionIndex + 1} of ${questions.length}',
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
                          ...sortedOptions.map((option) {
                            final isSelected = selectedAnswers[currentQuestionIndex] == option.key;
                            return GestureDetector(
                              onTap: timeUp ? null : () => _selectAnswer(option.key),
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
                                  '${option.key}) ${option.value}',
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
                            onPressed: currentQuestionIndex == questions.length - 1
                                ? () => _submitTest(questions)
                                : () => _nextQuestion(questions.length),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              currentQuestionIndex == questions.length - 1
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
      },
    );
  }
}