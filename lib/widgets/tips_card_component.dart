import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Re-adding google_fonts

class TipsCardComponent extends StatelessWidget {
  final String title;
  final String description;
  final double? width;
  final EdgeInsets? margin;

  const TipsCardComponent({
    super.key,
    required this.title,
    required this.description,
    this.width,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    // This container creates the white card with rounded corners and a subtle shadow
    return Container(
      width: width,
      margin: margin ?? const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // This is the blue accent line on the left
          Container(
            width: 4.0,
            // Adjust height based on text, or set a fixed one.
            // Let's make it flexible by not setting a fixed height here.
            height: 48.0, // Or perhaps get height from text? For now, a fixed height.
            decoration: BoxDecoration(
              color: const Color(0xFF0055FF), // An example blue color
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(width: 12.0),
          // The text content is in an Expanded Column to fill the remaining space
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // So column doesn't stretch infinitely
              children: [
                // Title Text
                Text(
                  title,
                  style: GoogleFonts.inter( // Using GoogleFonts like your button example
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4.0),
                // Description Text
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    color: Colors.black54,
                    height: 1.4, // Line height for better readability
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}