import 'package:flutter/material.dart';
import 'package:smartdrive/constants/app_colors.dart';
import 'package:smartdrive/models/provisional_question.dart';
import 'package:smartdrive/models/user_exam_stats.dart';
import 'package:smartdrive/screens/flashcard.dart';
import 'package:smartdrive/screens/mock_test_page.dart';
import 'package:smartdrive/services/auth_service.dart';
import 'package:smartdrive/services/provisional_exam_service.dart';
import 'package:smartdrive/services/preferences_service.dart';
import 'package:smartdrive/widgets/contact_us_card.dart';
import 'package:smartdrive/widgets/page_header.dart';

class ProvisionalExamPage extends StatelessWidget {
  const ProvisionalExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
                  // Page Header using PageHeader widget
                  PageHeader(
                    title: 'Provisional Exam',
                    subtitle: 'Practice for your provisional driving exam',
                    onBackPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _StatsSection(userId: user?.uid),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().add(const Duration(days: 14)),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          await PreferencesService.setExamDate(date);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Exam date set to ${date.day}/${date.month}/${date.year}')),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: const Text('Add Test Date'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
                                  Navigator.pushNamed(context, '/quiz');
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MockTestPage(),
                                    ),
                                  );
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
                                  Navigator.pushNamed(context, '/progress');
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ContactUsCard(),
                ],
              ),
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
            gradient: LinearGradient(
              colors: Theme.of(context).brightness == Brightness.dark
                  ? [
                      const Color(0xFF1A1A2E),
                      const Color(0xFF0F3460),
                    ]
                  : [
                      const Color(0xFFFFFFFF),
                      const Color(0xFFFDF6F6),
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
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

class _StatsSection extends StatelessWidget {
  const _StatsSection({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String? userId;

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF1A1A2E)
              : const Color(0xFFE6F0FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'Sign in to track your mock test attempts and keep stats synced across devices.',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
      );
    }

    return StreamBuilder<UserExamStats?>(
      stream: ProvisionalExamService.streamUserStats(userId!),
      builder: (context, snapshot) {
        final stats = snapshot.data;
        final testsTakenText = stats?.testsTaken.toString() ?? '0';
        final answeredText = stats?.questionsAnswered.toString() ?? '0';
        final accuracyText = stats != null
            ? '${stats.averageScore.toStringAsFixed(0)}%'
            : '0%';

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    value: accuracyText,
                    label: 'Average Score',
                    background: const Color(0xFFE6F0FF),
                    valueColor: const Color(0xFF0F47A1),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    value: testsTakenText,
                    label: 'Tests Taken',
                    background: const Color(0xFFFFF4E5),
                    valueColor: const Color(0xFFB25E09),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    value: answeredText,
                    label: 'Questions Answered',
                    background: const Color(0xFFE6FBF2),
                    valueColor: const Color(0xFF0E6A3C),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StreamBuilder<int>(
                    stream: ProvisionalExamService.streamQuestionCount(),
                    builder: (context, questionSnapshot) {
                      final total = questionSnapshot.data;
                      return _StatCard(
                        value: total?.toString() ?? '--',
                        label: 'Question Bank',
                        background: const Color(0xFFF0F0FF),
                        valueColor: const Color(0xFF3C1AB0),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.background,
    required this.valueColor,
  });

  final String value;
  final String label;
  final Color background;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A2E) : background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

