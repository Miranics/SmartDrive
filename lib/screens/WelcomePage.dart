import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartdrive/widgets/contact_us_card.dart';

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                bottom: 40,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF006FFF), Color(0xFF004299)],
                ),
              ),
              child: Center(
                child: Text(
                  "SmartDrive",
                  style: TextStyle(
                    fontFamily: "NicoMoji",
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF006FFF), Color(0xFF004299)],
                      ),
                    ),
                    child: Center(
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 38),
                  Text(
                    "Welcome!",
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Prepare for your driving exam with our comprehensive practice tools and expert tips.",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      height: 1.5,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 80),
                  // Card with icon, title, and description
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFD9EDFF), Color(0xFFC0E2FF)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFF0095FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.edit_document, // Replace with your icon
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: 12),
                            // Title
                            Expanded(
                              child: Text(
                                "Provisional Exam Practice",
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        // Description
                        Text(
                          "Practice with flashcards,\nquizzes, and mock tests for your\nprovisional written exam.",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Second card - Practical Driving Tips
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFD9EDFF), Color(0xFFC0E2FF)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFF0095FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.directions_car,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Practical Driving Tips",
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Practice with flashcards,\nquizzes, and mock tests for your\nprovisional written exam.",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 70),
                ],
              ),
            ),
            ContactUsCard(),
          ],
        ),
      ),
    );
  }
}
