import 'package:flutter/material.dart';
import 'package:smartdrive/widgets/button_component.dart';
import 'package:smartdrive/widgets/practice_quiz_card.dart';

void main() {
  runApp(const MaterialApp(home: Quizpage()));
}

class Quizpage extends StatelessWidget {
  const Quizpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Quiz App Example")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // --- Example 1: WITH an image ---
            PracticeQuizCard(
              questionText:
                  "What is the maximum speed limit in residential areas in Rwanda?",
              // Make sure 'assets/image_0.png' exists and is in pubspec.yaml
              imageAssetPath:
                  'assets/images/speed-limit-30-sign-260nw-2492496001.webp',
              options: const ["60 km/h", "30 km/h", "50 km/h", "40 km/h"],
              onOptionSelected: (index) {
                // This runs when a user taps an option.
                // index 0 is A, index 1 is B, etc.
                print("User tapped option index: $index for Q1");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Selected option index: $index")),
                );
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonComponent(
                type: ButtonType.secondary,
                text: "Next Question",
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
