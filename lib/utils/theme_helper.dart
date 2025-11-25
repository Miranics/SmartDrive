import 'package:flutter/material.dart';

class ThemeHelper {
  static Color getCardGradientStart(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1A1A2E)
        : const Color(0xFFD9EDFF);
  }

  static Color getCardGradientEnd(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF0F3460)
        : const Color(0xFFC0E2FF);
  }

  static Color getHeaderGradientStart(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1A1A2E)
        : const Color(0xFF006FFF);
  }

  static Color getHeaderGradientEnd(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF16213E)
        : const Color(0xFF004299);
  }

  static Color getIconBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF0F3460)
        : const Color(0xFF0095FF);
  }

  static Color getCardTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
  }

  static Color getPopupMenuColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1A1A2E)
        : Colors.white;
  }

  static Color getDialogBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1A1A2E)
        : Colors.white;
  }
}
