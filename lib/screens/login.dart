import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartdrive/screens/signup.dart';
import 'package:smartdrive/services/auth_service.dart';
import 'package:smartdrive/widgets/button_component.dart';
import 'package:smartdrive/widgets/input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      await AuthService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      await AuthService.reloadCurrentUser();
      final user = AuthService.currentUser;
      final isVerified = user?.emailVerified ?? false;

      if (!mounted) return;
      if (isVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Logged in successfully. Welcome back!')),
        );
      } else {
        await AuthService.sendVerificationEmail();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Verification link sent to ${user?.email ?? 'your email'}. Open it, confirm, then tap "I verified" on the next screen.',
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      final message = e.message ?? 'Login failed';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<void> _navigateToSignup() async {
    final result = await Navigator.of(context).pushNamed<String>('/signup');
    if (!mounted) return;
    if (result != null && result.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF6FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: Color(0xFF004299),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                InputComponent(
                  label: 'Email',
                  text: 'you@example.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                InputComponent(
                  label: 'Password',
                  text: '••••••••',
                  controller: _passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() => _rememberMe = value ?? false);
                          },
                          activeColor: const Color(0xFF004299),
                        ),
                        Text(
                          'Remember me',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF004299),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Password reset coming soon.')),
                        );
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ButtonComponent(
                  text: 'Log In',
                  type: ButtonType.primary,
                  onPressed: _handleLogin,
                  isLoading: _isSubmitting,
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: _isSubmitting ? null : _navigateToSignup,
                  child: Text(
                    "Don't have an account? Sign up",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF004299),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
