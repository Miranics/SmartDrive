import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF004299);
  static const Color lightBlue = Color(0xFFC0E2FF);
  static const Color veryLightBlue = Color(0xFFEBF6FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
}

class AppTextStyles {
  AppTextStyles._();

  static const String nicoMoji = 'NicoMoji';
  
  static const TextStyle heading = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}

class AppSizes {
  AppSizes._();

  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
}
