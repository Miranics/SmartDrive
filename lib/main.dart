import 'package:flutter/material.dart';

import 'pages/progress_card_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProgressDemoPage(),
    );
  }
}
