import 'package:flutter/material.dart';
import 'package:smartdrive/widgets/button_component.dart';
import 'package:smartdrive/widgets/input.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF6FF),
      body: Column(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(top: 151, bottom: 50),
            child: Text(
              "Log In",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Color(0xFF004299),
                ),
              ),
            ),
          ),
          InputComponent(label: "Username"),
          SizedBox(height: 10),
          InputComponent(label: "Password"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Color(0xFF004299); // Checked: dark blue
                      }
                      return Color(0xFFEBF6FF); // Unchecked: same as background
                    }),
                    side: BorderSide(
                      color: Color(0xFF004299), // Border color
                      width: 2,
                    ),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Text(
                    "Remember me",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                        color: Color(0xFF004299),
                      ),
                    ),
                  ),
                ],
              ),

              Text(
                "Forget Password",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                    color: Color(0xFF004299),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 34),
          ButtonComponent(
            text: "Log In",
            type: ButtonType.primary,
            onPressed: () => {},
          ),
          SizedBox(height: 70),

          RichText(
            text: TextSpan(
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: Color(0xFF004299),
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(text: "Don't have an account? "),
                TextSpan(
                  text: "Sign up",
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
    );
  }
}
