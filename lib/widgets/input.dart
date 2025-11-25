import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputComponent extends StatefulWidget {
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
  final bool showPasswordToggle;

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
    this.showPasswordToggle = false,
  });

  @override
  State<InputComponent> createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponent> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(left: 8, bottom: 6),
            child: Text(
              widget.label!,
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
            controller: widget.controller,
            validator: widget.validator,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onFieldSubmitted,
            autofillHints: widget.autofillHints,
            enableSuggestions: widget.enableSuggestions,
            autocorrect: widget.autocorrect,
            style:
                widget.fieldTextStyle ??
                GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: widget.textColor ?? Color(0xFF004299),
                ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFEBF6FF),
              hintText: widget.text,
              hintStyle:
                  widget.fieldHintStyle ??
                  GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: widget.hintTextColor ?? Color(0xFF004299),
                  ),
              suffixIcon: widget.showPasswordToggle
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFF004299),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: BorderSide(color: widget.borderColor ?? Color(0xFF004299)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: BorderSide(
                  color: widget.focusedBorderColor ?? Color(0xFF004299),
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
