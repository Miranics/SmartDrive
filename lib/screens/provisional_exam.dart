import 'package:flutter/material.dart';
import 'package:smartdrive/widgets/page_header.dart';
import 'package:smartdrive/widgets/contact_us_card.dart';
import 'package:smartdrive/constants/app_colors.dart';
import 'package:smartdrive/screens/flashcard.dart';

class ProvisionalExamPage extends StatelessWidget {
  const ProvisionalExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Page Header using PageHeader widget
                  PageHeader(
                    title: 'Provisional Exam',
                    subtitle: 'Practice for your provisional driving exam',
                    onBackPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 24),
                  // Stats Cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            '85%',
                            'Average Score',
                            Colors.blue[50]!,
                            const Color(0xFF0066FF),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            '3',
                            'Tests Taken',
                            Colors.blue[50]!,
                            const Color(0xFF0066FF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Add Test Date Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Add test date action
                      },
                      icon: const Icon(Icons.add_circle_outline, size: 20),
                      label: const Text('Add Test Date'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryBlue,
                        side: const BorderSide(color: AppColors.primaryBlue),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Feature Cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildFeatureCard(
                                context,
                                Icons.style_outlined,
                                'Flashcards',
                                'Study key concepts',
                                Colors.purple[50]!,
                                Colors.purple,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FlashcardPage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildFeatureCard(
                                context,
                                Icons.quiz_outlined,
                                'Practice Quiz',
                                'Test your knowledge',
                                Colors.blue[50]!,
                                Colors.blue,
                                onTap: () {
                                  // Navigate to practice quiz
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildFeatureCard(
                                context,
                                Icons.assignment_outlined,
                                'Mock tests',
                                'Full exam stimulation',
                                Colors.indigo[50]!,
                                Colors.indigo,
                                onTap: () {
                                  // Navigate to mock tests
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildFeatureCard(
                                context,
                                Icons.trending_up_outlined,
                                'Progress',
                                'Track your improvement',
                                Colors.green[50]!,
                                Colors.green,
                                onTap: () {
                                  // Navigate to progress
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          // Contact Us Footer - always visible at bottom, fills entire width
          ContactUsCard(),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color bgColor,
    Color? iconColor, {
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: iconColor?.withOpacity(0.2),
        highlightColor: iconColor?.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFDF6F6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}