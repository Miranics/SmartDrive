import 'package:flutter/material.dart';
import 'package:smartdrive/widgets/input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputComponent(text: "Name"),
              SizedBox(height: 16),
              InputComponent(text: "Email"),
              SizedBox(height: 16),
              InputComponent(text: "Password"),
              SizedBox(height: 16),
              InputComponent(text: "Confirm Password"),
            ],
          ),
        ),
      ),
    );
  }
}
