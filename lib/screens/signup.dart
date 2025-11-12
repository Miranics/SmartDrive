import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartdrive/widgets/button_component.dart';
import 'package:smartdrive/widgets/input.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF6FF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(13),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 100,
                  right: 100,
                  top: 47,
                  bottom: 93,
                ),
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: Color(0xFF004299),
                    ),
                  ),
                ),
              ),
              // Inputs use default styles defined in the component
              InputComponent(text: "Name"),
              SizedBox(height: 13),
              InputComponent(text: "Email"),
              SizedBox(height: 13),
              InputComponent(text: "Password"),
              SizedBox(height: 13),
              InputComponent(text: "Confirm Password"),
              SizedBox(height: 70),
              ButtonComponent(
                text: "Sign Up",
                type: ButtonType.primary,
                onPressed: () => {},
              ),
              SizedBox(height: 37),
              // Static styled line without hover/setState
              RichText(
                text: TextSpan(
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Color(0xFF004299),
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(text: "Already have an account? "),
                    TextSpan(
                      text: "Log in",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF004299),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
