import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RouteGuard extends StatelessWidget {
  final Widget child;
  final bool requireAuth;

  const RouteGuard({
    super.key,
    required this.child,
    this.requireAuth = true,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final isAuthenticated = user != null && user.emailVerified;

    if (requireAuth && !isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamedAndRemoveUntil('/homepage', (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login to access this page')),
        );
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return child;
  }
}
