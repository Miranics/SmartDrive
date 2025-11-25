import 'package:flutter/material.dart';
import 'package:smartdrive/constants/app_colors.dart';
import 'package:smartdrive/widgets/page_header.dart';
import 'package:smartdrive/widgets/contact_us_card.dart';
import 'package:smartdrive/widgets/button_component.dart';
import 'package:smartdrive/screens/mock_test_questions.dart';

class MockTestPage extends StatelessWidget {
  const MockTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
                    color: AppColors.white,
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
                      const Text(
                        'Ready for the Test?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      
                      // Description
                      const Text(
                        'This test contains 20 questions similar to the real exam. You have 20 minutes to complete it.',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textPrimary,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}