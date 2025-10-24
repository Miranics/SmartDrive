import 'package:flutter/material.dart';

class InputComponent extends StatelessWidget {
  final String? text;
  final String? label;
  final Color? textColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;

  const InputComponent({
    super.key,
    this.text,
    this.label,
    this.textColor,
    this.borderColor,
    this.focusedBorderColor,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
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
            style: TextStyle(color: textColor ?? Color(0xFF004299)),
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              hintText: text,
              hintStyle: TextStyle(color: Color(0xFF004299)),
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
