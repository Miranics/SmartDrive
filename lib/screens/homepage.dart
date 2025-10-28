import 'package:flutter/material.dart';
import 'package:smartdrive/widgets/button_component.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC0E2FF),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", width: 382, height: 138),
              Transform.translate(
                offset: Offset(0, -38),
                child: Text(
                  "SmartDrive",
                  style: TextStyle(
                    fontFamily: "NicoMoji",
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF004299),
                  ),
                ),
              ),
              // SizedBox(height: 40),
              Text(
                "At Smart Drive, we're dedicated to make your driving learning experience seamless and enjoyable.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Practice for your provisional license with flashcards, quizzes, and mock tests, and get tips on the practical driving exam.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 100),
              ButtonComponent(
                text: "Start Now",
                backgroundColor: Color(0xFF004299),
                type: ButtonType.small,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
