import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputComponent extends StatelessWidget {
  final String? text;
  final String? label;
  final Color? textColor;
  final TextStyle? fieldTextStyle;
  final TextStyle? fieldHintStyle;
  final Color? hintTextColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final Iterable<String>? autofillHints;
  final bool enableSuggestions;
  final bool autocorrect;

  const InputComponent({
    super.key,
    this.text,
    this.label,
    this.textColor,
    this.fieldTextStyle,
    this.fieldHintStyle,
    this.hintTextColor,
    this.borderColor,
    this.focusedBorderColor,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.autofillHints,
    this.enableSuggestions = true,
    this.autocorrect = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null)
          Padding(
            padding: EdgeInsets.only(left: 8, bottom: 6),
            child: Text(
              label!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF004299),
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: TextFormField(
            controller: controller,
            validator: validator,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            autofillHints: autofillHints,
            enableSuggestions: enableSuggestions,
            autocorrect: autocorrect,
            style:
                fieldTextStyle ??
                GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: textColor ?? Color(0xFF004299),
                ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFEBF6FF),
              hintText: text,
              hintStyle:
                  fieldHintStyle ??
                  GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: hintTextColor ?? Color(0xFF004299),
                  ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: BorderSide(color: borderColor ?? Color(0xFF004299)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: BorderSide(
                  color: focusedBorderColor ?? Color(0xFF004299),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
