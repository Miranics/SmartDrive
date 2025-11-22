import 'package:flutter/material.dart';
import '../widgets/progress_bar.dart';

class ProgressDemoPage extends StatelessWidget {
  const ProgressDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        title: const Text('My Learning Progress'),
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
        ],
      ),
    );
  }
}