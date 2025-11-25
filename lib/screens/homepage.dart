import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartdrive/services/auth_service.dart';
import 'package:smartdrive/widgets/button_component.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC0E2FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('SmartDrive'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 260, height: 120),
              const SizedBox(height: 12),
              const Text(
                'SmartDrive',
                style: TextStyle(
                  fontFamily: 'NicoMoji',
                  fontSize: 40,
                  color: Color(0xFF004299),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "At SmartDrive, we're dedicated to making your driving learning experience seamless and enjoyable.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 16, height: 1.5, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              Text(
                'Practice for your provisional license with flashcards, quizzes, and mock tests, and get tips on the practical driving exam.',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 16, height: 1.5, color: Colors.black87),
              ),
              const SizedBox(height: 30),
              ButtonComponent(
                text: 'Start Now',
                backgroundColor: const Color(0xFF004299),
                type: ButtonType.small,
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  'Already have an account? Log in',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF004299),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
