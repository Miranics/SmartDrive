import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final int currentProgress;
  final int totalProgress;
  final Color? progressColor;
  final Color? backgroundColor;

  const ProgressCard({
    super.key,
    required this.title,
    required this.currentProgress,
    required this.totalProgress,
    this.progressColor,
    this.backgroundColor,
  }) : assert(currentProgress >= 0 && currentProgress <= totalProgress,
            'currentProgress must be between 0 and totalProgress');

  int get percentage => totalProgress > 0 
      ? ((currentProgress / totalProgress) * 100).round() 
      : 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1A1A2E)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF007AFF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 8,
              child: LinearProgressIndicator(
                value: totalProgress > 0 ? currentProgress / totalProgress : 0,
                backgroundColor: backgroundColor ?? const Color(0xFFE5E5EA),
                valueColor: AlwaysStoppedAnimation<Color>(
                  progressColor ?? const Color(0xFF007AFF),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$currentProgress/$totalProgress questions mastered',
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF8E8E93),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressCardExample extends StatelessWidget {
  const ProgressCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        title: const Text('SmartDrive Progress'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: const [
          ProgressCard(
            title: 'Traffic Signs',
            currentProgress: 47,
            totalProgress: 50,
          ),
          ProgressCard(
            title: 'Road Safety',
            currentProgress: 42,
            totalProgress: 50,
          ),
          ProgressCard(
            title: 'Vehicle Control',
            currentProgress: 44,
            totalProgress: 50,
          ),
        ],
      ),
    );
  }
}
