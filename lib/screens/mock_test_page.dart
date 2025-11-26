import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartdrive/constants/app_colors.dart';
import 'package:smartdrive/widgets/page_header.dart';
import 'package:smartdrive/widgets/contact_us_card.dart';
import 'package:smartdrive/widgets/button_component.dart';
import 'package:smartdrive/screens/mock_test_questions.dart';

class MockTestPage extends ConsumerWidget {
  const MockTestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Page Header
          PageHeader(
            title: 'Mock Test',
            subtitle: 'Full Exam stimulation',
            onBackPressed: () {
              Navigator.pop(context);
            },
          ),
          
          // Main Content
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1A1A2E)
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primaryBlue,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.paleBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.description_outlined,
                          size: 60,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Title
                      Text(
                        'Ready for the Test?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      
                      // Description
                      Text(
                        'This test contains 20 questions similar to the real exam. You have 20 minutes to complete it.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      
                      // Test Details
                      _buildDetailRow('Questions:', '20'),
                      const SizedBox(height: 12),
                      _buildDetailRow('Time Limit:', '20 minutes'),
                      const SizedBox(height: 12),
                      _buildDetailRow('Pass Mark:', '60%'),
                      const SizedBox(height: 32),
                      
                      // Start Test Button
                      ButtonComponent(
                        text: 'Start Test',
                        type: ButtonType.secondary,
                        onPressed: () {
                          // Reset all providers for fresh quiz
                          ref.invalidate(mockTestQuestionsProvider);
                          ref.invalidate(currentQuestionIndexProvider);
                          ref.invalidate(selectedAnswersProvider);
                          ref.invalidate(secondsRemainingProvider);
                          ref.invalidate(timeUpProvider);
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MockTestQuestionsPage(),
                            ),
                          );
                        },
                      ), 
                    ],
                  ),
                ),
              ),
              // Contact Us Card
              const ContactUsCard(),
            ],
          ),
        ),
      ),  
    ],
  ),
);
}

  Widget _buildDetailRow(String label, String value) {
    return Builder(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}