import 'package:flutter/material.dart';
import 'package:smartdrive/constants/app_colors.dart';
import 'package:smartdrive/widgets/page_header.dart';
import 'package:smartdrive/widgets/contact_us_card.dart';
import 'package:smartdrive/widgets/button_component.dart';

class MockTestScoresPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int timeUsed; // in seconds

  const MockTestScoresPage({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeUsed,
  });

  int get percentage => ((correctAnswers / totalQuestions) * 100).round();
  bool get passed => percentage >= 60;

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes}m ${secs}s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Page Header
          PageHeader(
            title: 'Test Results',
            subtitle: 'Your mock test performance',
            onBackPressed: () {
              Navigator.pop(context);
            },
          ),
          
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Content with padding
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Result Icon
                        Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: passed ? AppColors.mint.withOpacity(0.1) : AppColors.coral.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      passed ? Icons.check_circle_outline : Icons.cancel_outlined,
                      size: 70,
                      color: passed ? AppColors.teal : AppColors.red,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Result Title
                  Text(
                    passed ? 'Congratulations!' : 'Keep Practicing!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: passed ? AppColors.teal : AppColors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  
                  // Result Message
                  Text(
                    passed 
                        ? 'You passed the mock test! You\'re ready for the real exam.'
                        : 'You didn\'t pass this time, but don\'t give up! Keep studying and try again.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  
                  // Score Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF1A1A2E)
                          : AppColors.paleBlue,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primaryBlue,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Score Percentage
                        Text(
                          '$percentage%',
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: passed ? AppColors.teal : AppColors.red,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your Score',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Divider
                        Container(
                          height: 1,
                          color: AppColors.primaryBlue.withOpacity(0.3),
                        ),
                        const SizedBox(height: 24),
                        
                        // Details
                        _buildDetailRow(
                          'Correct Answers',
                          '$correctAnswers / $totalQuestions',
                          Icons.check_circle,
                          AppColors.teal,
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                          'Wrong Answers',
                          '${totalQuestions - correctAnswers} / $totalQuestions',
                          Icons.cancel,
                          AppColors.red,
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                          'Time Used',
                          _formatTime(timeUsed),
                          Icons.timer,
                          AppColors.amber,
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                          'Pass Mark',
                          '60%',
                          Icons.info_outline,
                          AppColors.primaryBlue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Action Buttons
                  ButtonComponent(
                    text: 'Try Again',
                    type: ButtonType.small,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  OutlinedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                      side: const BorderSide(
                        color: AppColors.primaryBlue,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  
                  // Contact Us Card - Full width, no padding
                  const ContactUsCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}