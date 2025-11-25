import 'package:flutter/material.dart';
import 'package:smartdrive/models/provisional_question.dart';
import 'package:smartdrive/models/user_exam_stats.dart';
import 'package:smartdrive/services/auth_service.dart';
import 'package:smartdrive/services/provisional_exam_service.dart';

class ProvisionalExamPage extends StatelessWidget {
  const ProvisionalExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Combined Gradient AppBar and Header
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF006FFF),
                    Color(0xFF0055CC),
                    Color(0xFF004299),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // AppBar section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const Text(
                            'Provisional Exam',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Subtitle section
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                      child: const Text(
                        'Prepare for your provisional driving exam',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Stats Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _StatsSection(userId: user?.uid),
            ),
            const SizedBox(height: 20),
            // Add Test Data Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton.icon(
                onPressed: () {
                  // Add test data action
                },
                icon: const Icon(Icons.add_circle_outline, size: 20),
                label: const Text('Add Test Data'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0066FF),
                  side: const BorderSide(color: Color(0xFF0066FF)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const _QuestionPreview(),
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
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.pushNamed(context, '/quiz');
                          },
                          child: _buildFeatureCard(
                            context,
                            Icons.quiz_outlined,
                            'Practice Quiz',
                            'Test your knowledge',
                            Colors.blue[50]!,
                            Colors.blue,
                          ),
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
                          'Full-length practice',
                          Colors.indigo[50]!,
                          Colors.indigo,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.pushNamed(context, '/progress');
                          },
                          child: _buildFeatureCard(
                            context,
                            Icons.trending_up_outlined,
                            'Progress',
                            'Track improvement',
                            Colors.green[50]!,
                            Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Contact Us Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF0066FF),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Us',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildContactRow(
                      Icons.email_outlined, 'smartdrive@gmail.com'),
                  const SizedBox(height: 8),
                  _buildContactRow(Icons.phone_outlined, '+250 785 456 678'),
                ],
              ),
            ),
            const SizedBox(height: 32),
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
    Color? iconColor,
  ) {
    return Container(
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
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
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
          color: const Color(0xFFF0F4FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE0E7FF)),
        ),
        child: const Text(
          'Sign in to track your attempts and keep your provisional exam progress synced across devices.',
          style: TextStyle(
            color: Color(0xFF1B2A52),
            fontSize: 14,
            height: 1.4,
          ),
        ),
      );
    }

    return StreamBuilder<UserExamStats?>(
      stream: ProvisionalExamService.streamUserStats(userId!),
      builder: (context, snapshot) {
        final stats = snapshot.data;
        final testsTaken = stats?.testsTaken.toString() ?? '--';
        final questionsAnswered = stats?.questionsAnswered.toString() ?? '--';
        final accuracy = (stats == null || stats.questionsAnswered == 0)
            ? '--'
            : '${stats.averageScore.toStringAsFixed(0)}%';

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    value: testsTaken,
                    label: 'Tests Taken',
                    background: const Color(0xFFE6F0FF),
                    valueColor: const Color(0xFF0F47A1),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    value: accuracy,
                    label: 'Average Score',
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
                    value: questionsAnswered,
                    label: 'Questions Answered',
                    background: const Color(0xFFE6FBF2),
                    valueColor: const Color(0xFF0E6A3C),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StreamBuilder<int>(
                    stream:
                        ProvisionalExamService.streamQuestionCount(),
                    builder: (context, questionSnapshot) {
                      final totalQuestions = questionSnapshot.data;
                      final value =
                          totalQuestions != null ? totalQuestions.toString() : '--';
                      return _StatCard(
                        value: value,
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 10,
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
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionPreview extends StatelessWidget {
  const _QuestionPreview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProvisionalQuestion>>(
      stream: ProvisionalExamService.streamQuestions(),
      builder: (context, snapshot) {
        final totalQuestions = snapshot.data?.length ?? 0;
        final header = Row(
          children: [
            const Text(
              'Question Bank Preview',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F2A44),
              ),
            ),
            const Spacer(),
            if (totalQuestions > 0)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A48C4).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$totalQuestions Qs',
                  style: const TextStyle(
                    color: Color(0xFF1A48C4),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        );

        Widget body;
        if (snapshot.connectionState == ConnectionState.waiting) {
          body = const Padding(
            padding: EdgeInsets.symmetric(vertical: 28),
            child: Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        } else if (snapshot.hasError) {
          body = const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Unable to load questions right now. Please try again shortly.',
              style: TextStyle(color: Colors.redAccent),
            ),
          );
        } else {
          final questions = snapshot.data ?? [];
          if (questions.isEmpty) {
            body = const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No questions are available yet. Use the "Add Test Data" button to seed your exam bank.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1F2A44),
                  height: 1.4,
                ),
              ),
            );
          } else {
            final question = questions.first;
            body = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 12),
                ...question.sortedOptions.take(3).map(
                  (option) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            option.key.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFF1A48C4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option.value,
                            style: const TextStyle(
                              color: Color(0xFF1F2937),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Correct answer: ${question.correctAnswer.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF047857),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Work through the full question bank inside the Practice Quiz.',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/quiz');
                    },
                    icon: const Icon(Icons.play_circle_outline),
                    label: const Text('Start Practice Quiz'),
                  ),
                ),
              ],
            );
          }
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.05),
                offset: const Offset(0, 6),
                blurRadius: 12,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
              const SizedBox(height: 12),
              body,
            ],
          ),
        );
      },
    );
  }
}
