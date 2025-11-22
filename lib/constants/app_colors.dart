import 'package:flutter/material.dart';

/// App color palette
/// Contains all colors used throughout the application
class AppColors {
  // Prevent instantiation
  AppColors._();

  // Neutral and Primary colors
  static const Color lightGray = Color(0xFFE5E5E5);
  static const Color black = Color(0xFF000000);
  static const Color primaryBlue = Color(0xFF006FFF);
  static const Color darkBlue = Color(0xFF004299);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF5F5F5);
  static const Color lightBlue = Color(0xFFC0E2FF);
  static const Color paleBlue = Color(0xFFD9EDFF);

  // Accent colors
  static const Color paleGray = Color(0xFFEEEEEE);
  static const Color teal = Color(0xFF00E696);
  static const Color skyBlue = Color(0xFF2196F3);
  static const Color amber = Color(0xFFFFA600);
  static const Color burntAmber = Color(0xFFC8973C);
  static const Color red = Color(0xFFFF5555);
  static const Color coral = Color(0xFFF28787);
  static const Color mint = Color(0xFF00C882);

  // Gradient colors (commonly used together)
  static const List<Color> primaryBlueGradient = [
    primaryBlue,
    darkBlue,
  ];

  static const List<Color> primaryTealGradient = [
    teal,
    mint,
  ];

  static const List<Color> primaryAmberGradient = [
    amber,
    burntAmber,
  ];

  static const List<Color> primaryRedGradient = [
    red,
    coral,
  ];

  // Semantic color naming for specific use cases
  static const Color background = white;
  static const Color backgroundLight = offWhite;
  static const Color textPrimary = black;
  static const Color textSecondary = white;
  static const Color textOnPrimary = primaryBlue;
  static const Color backgroundHome = lightBlue;
  static const Color backgroundSignIn = paleBlue;

  //Progress screen colors

  static const Color readiness = teal;
  static const Color countdown = red;
  static const Color streak = amber;

  // Button colors
  static const Color buttonPrimary = primaryBlue;
  static const Color buttonDisabled = lightGray;

  /// Creates a linear gradient with primary colors
  static LinearGradient getPrimaryBlueGradient({
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: primaryBlueGradient, 
    );
  }

  static LinearGradient getPrimaryTealGradient({
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: primaryTealGradient, 
    );
  }

  static LinearGradient getPrimaryAmberGradient({
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: primaryAmberGradient, 
    );
  }

  static LinearGradient getPrimaryRedGradient({
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: primaryRedGradient, 
    );
  }
}