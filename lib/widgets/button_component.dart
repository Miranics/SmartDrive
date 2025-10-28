import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ButtonType { primary, secondary, small, outlined }

class ButtonComponent extends StatelessWidget {
  final String text;
  final ButtonType type;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final OutlinedBorder? shape;
  final EdgeInsets? margin;
  const ButtonComponent({
    super.key,
    required this.text,
    required this.type,
    required this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.shape,
    this.margin,
  });
  Color _getBackgroundColor() {
    if (backgroundColor != null) {
      return backgroundColor!;
    }
    switch (type) {
      case ButtonType.primary:
        return Color(0xFF004299);
      case ButtonType.secondary:
        return Color(0xFF006FFF);
      case ButtonType.small:
        return Color(0xFF006FFF);
      case ButtonType.outlined:
        return Colors.white;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case ButtonType.primary:
        return Colors.white;
      case ButtonType.secondary:
        return Colors.white;
      case ButtonType.small:
        return Colors.white;
      case ButtonType.outlined:
        return Color(0xFF006FFF);
    }
  }

  EdgeInsets _getPadding() {
    switch (type) {
      case ButtonType.primary:
        return EdgeInsets.symmetric(horizontal: 40, vertical: 10);
      case ButtonType.secondary:
        return EdgeInsets.symmetric(horizontal: 48, vertical: 23);
      case ButtonType.small:
        return EdgeInsets.symmetric(horizontal: 65, vertical: 22);
      case ButtonType.outlined:
        return EdgeInsets.symmetric(horizontal: 65, vertical: 22);
    }
  }

  double _getFontSize() {
    switch (type) {
      case ButtonType.primary:
        return 25;
      case ButtonType.secondary:
        return 22;
      case ButtonType.small:
        return 22;
      case ButtonType.outlined:
        return 24;
    }
  }

  double? _getWidth() {
    if (width != null) return width;
    switch (type) {
      case ButtonType.primary:
        return 500;
      case ButtonType.secondary:
        return 326;
      case ButtonType.small:
        return null;
      case ButtonType.outlined:
        return null;
    }
  }

  OutlinedBorder _getShape() {
    if (shape != null) return shape!;
    switch (type) {
      case ButtonType.primary:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
      case ButtonType.secondary:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
      case ButtonType.small:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
      case ButtonType.outlined:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Color(0xFF006FFF), width: 3),
        );
    }
  }

  EdgeInsets? _getMargin() {
    if (margin != null) return margin;
    switch (type) {
      case ButtonType.primary:
        return EdgeInsets.symmetric(horizontal: 20);
      case ButtonType.secondary:
        return null;
      case ButtonType.small:
        return null;
      case ButtonType.outlined:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _getMargin(),
      child: SizedBox(
        width: _getWidth(),
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: _getBackgroundColor(),
            foregroundColor: _getTextColor(),
            padding: _getPadding(),
            shape: _getShape(),
          ),
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
              fontSize: _getFontSize(),
              color: _getTextColor(),
            ),
          ),
        ),
      ),
    );
  }
}
