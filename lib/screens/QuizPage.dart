import 'package:flutter/material.dart';
import 'package:smartdrive/widgets/button_component.dart';
import 'package:smartdrive/widgets/contact_us_card.dart';
import 'package:smartdrive/widgets/page_header.dart';
import 'package:smartdrive/widgets/practice_quiz_card.dart';
import 'package:smartdrive/widgets/progress_bar.dart';

/// Quiz page with question, options, and progress tracking
class Quizpage extends StatelessWidget {
  const Quizpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with title and subtitle
            PageHeader(title: "Practice Quiz", subtitle: "Questions 1 to 10"),

            // Progress tracker (1 out of 10 questions)
            const ProgressCard(
              title: 'Quiz Progress',
              currentProgress: 1,
              totalProgress: 10,
            ),

            const SizedBox(height: 20),

            // Quiz question with image and multiple choice options
            PracticeQuizCard(
              questionText:
                  "What is the maximum speed limit in residential areas in Rwanda?",
              imageAssetPath:
                  'assets/images/speed-limit-30-sign-260nw-2492496001.webp',
              options: const ["60 km/h", "30 km/h", "50 km/h", "40 km/h"],
              onOptionSelected: (index) {
                // Show selected option feedback
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Selected option: ${index + 1}")),
                );
              },
            ),

            const SizedBox(height: 20),

            // Next question button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ButtonComponent(
                type: ButtonType.secondary,
                text: "Next Question",
                onPressed: () {
                  // TODO: Navigate to next question
                },
              ),
            ),

            const SizedBox(height: 20),

            // Contact information card
            const ContactUsCard(),
          ],
        ),
      ),
    );
  }
}
