import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/tips_card_component.dart';

class PracticalTipsScreen extends StatelessWidget {
  const PracticalTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This is the primary blue color from your app's design
    const Color primaryBlue = Color(0xFF004299);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // The back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // This will take the user back to the previous screen
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: primaryBlue,
        elevation: 0, // Removes shadow for a flat design
        // Using 'title' to hold both title and subtitle
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Practical Tips",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              "Expert advice for your driving test.",
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.9),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      // The body is the scrollable list of tips
      body: ListView(
        // Padding for the top and bottom of the list
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: const [
          // Here we re-use the component you made!
          TipsCardComponent(
            title: "Cones Exam",
            description:
                "This first part of the practical driving exam is simple, but requires keen attention to surroundings.",
          ),
          TipsCardComponent(
            title: "Parallel Parking Exam",
            description:
                "Practice this maneuver extensively. Use reference points. It has a 2 minute time limit.",
          ),
          TipsCardComponent(
            title: "Circulation Exam",
            description:
                "Time to hit the road! You must remain calm and follow the instructor's tells. Watch out for the trick questions!",
          ),
          TipsCardComponent(
            title: "T - Cross Exam",
            description:
                "Always check your mirrors and blind spots, and be sure to turn on your double indicator while reversing.",
          ),
          TipsCardComponent(
            title: "Demerage Exam",
            description:
                "The final part of the exam where you control the car on a steep hill. Remain calm, listen to the car and the instructors signal.",
          ),
        ],
      ),
      // The blue footer is created using bottomNavigationBar
      bottomNavigationBar: Container(
        color: primaryBlue,
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // So it only takes up needed space
          children: [
            Text(
              "Contact Us",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "smartdrive@gmail.com",
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "+250 782 345 678",
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}