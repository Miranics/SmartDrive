import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartdrive/services/auth_service.dart';
import 'package:smartdrive/widgets/button_component.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key, required this.user});

  final User user;

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool _isSending = false;
  bool _isChecking = false;

  String get _emailLabel => widget.user.email ?? 'your inbox';

  Future<void> _resendEmail() async {
    setState(() => _isSending = true);
    try {
  await AuthService.sendVerificationEmail(force: true);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification email sent to $_emailLabel.')),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      final message = e.message ?? 'Failed to send verification email.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  Future<void> _refreshStatus() async {
    setState(() => _isChecking = true);
    try {
      await AuthService.reloadCurrentUser();
      final refreshedUser = AuthService.currentUser;
      final isVerified = refreshedUser?.emailVerified ?? false;

      if (!mounted) return;
      if (isVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email verified! Loading your dashboard...')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Still waiting for confirmation on $_emailLabel. Check spam and try again.'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not refresh status: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isChecking = false);
      }
    }
  }

  Future<void> _signOut() async {
    await AuthService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF6FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 48,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text(
                  'Verify your email',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF004299),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'We need to confirm it is you before granting access. A verification link has been sent to:',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
                const SizedBox(height: 12),
                Text(
                  _emailLabel,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF004299),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Didn\'t receive it? Check your spam folder or resend the email below.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 15),
                ),
                const SizedBox(height: 32),
                ButtonComponent(
                  text: 'Resend verification email',
                  type: ButtonType.primary,
                  onPressed: _isSending ? null : _resendEmail,
                  isLoading: _isSending,
                ),
                const SizedBox(height: 16),
                ButtonComponent(
                  text: 'I\'ve verified, refresh status',
                  type: ButtonType.secondary,
                  onPressed: _isChecking ? null : _refreshStatus,
                  isLoading: _isChecking,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _signOut,
                  child: const Text('Use a different email / Sign out'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
