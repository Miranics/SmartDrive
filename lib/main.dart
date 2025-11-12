import 'package:flutter/material.dart';
import 'package:smartdrive/screens/homepage.dart';
import 'package:smartdrive/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Signup()));
  }
}
