import 'package:flutter/material.dart';
import 'package:smartdrive/widgets/practice_quiz_card.dart';

class Quizpage extends StatefulWidget {
  const Quizpage({super.key});

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PracticeQuizCard(
        subtitle: 'Question 1 of 10',
        progress: 0.1,
        question: 'What does a red traffic light mean?',
        options: [
          'Stop completely',
          'Slow down and proceed with caution',
          'Speed up to clear the intersection',
          'Stop only if other vehicles are present',
        ],
        selectedIndex: selectedIndex,
        onOptionSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        onNext: () {
          // Handle next question
          print('Next question');
        },
        onBack: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
