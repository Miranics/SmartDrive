import 'package:flutter/material.dart';
import 'package:smartdrive/widgets/user_status.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: UserStatCard(
            icon: Icons.home,
            percentage: "80%",
            label: "Average Score",
          ),
        ),
      ),
    );
  }
}
