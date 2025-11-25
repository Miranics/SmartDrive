import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartdrive/services/auth_service.dart';

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

  Widget _actionButton({
    required String label,
    required Future<void> Function() onTap,
    required bool isBusy,
    bool isPrimary = true,
  }) {
    final textStyle = GoogleFonts.montserrat(
      fontWeight: FontWeight.w600,
      fontSize: 15,
      color: isPrimary ? Colors.white : const Color(0xFF004299),
    );

    final buttonChild = isBusy
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(label, style: textStyle);

    final padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 18);
    final size = const Size.fromHeight(44);

    if (isPrimary) {
      return FilledButton(
        style: FilledButton.styleFrom(
          minimumSize: size,
          padding: padding,
          backgroundColor: const Color(0xFF004299),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: isBusy ? null : () => onTap(),
        child: buttonChild,
      );
    }

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: size,
        padding: padding,
        foregroundColor: const Color(0xFF004299),
        side: const BorderSide(color: Color(0xFF004299)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: isBusy ? null : () => onTap(),
      child: buttonChild,
    );
  }

  @override
  Widget build(BuildContext context) {
    final topSpacing = MediaQuery.of(context).size.height * 0.04;

    return Scaffold(
      backgroundColor: const Color(0xFFEBF6FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: topSpacing),
                Text(
                  'Verify your email',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF004299),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'We sent a verification link to:',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  _emailLabel,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF004299),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Didn\'t receive anything? Check your spam folder or resend below.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 13.5, color: Colors.black87),
                ),
                const SizedBox(height: 28),
                _actionButton(
                  label: 'Resend verification email',
                  onTap: _resendEmail,
                  isBusy: _isSending,
                  isPrimary: true,
                ),
                const SizedBox(height: 12),
                _actionButton(
                  label: 'I\'ve verified – refresh',
                  onTap: _refreshStatus,
                  isBusy: _isChecking,
                  isPrimary: false,
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _signOut,
                  child: const Text('Use a different email / Sign out'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
