import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smartdrive/config/runtime_env.dart';
import 'package:smartdrive/firebase_options.dart';
import 'package:smartdrive/screens/homepage.dart';
import 'package:smartdrive/screens/login.dart';
import 'package:smartdrive/screens/verify_email.dart';
import 'package:smartdrive/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _loadEnvFile();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: RuntimeEnv.supabaseUrl,
    anonKey: RuntimeEnv.supabaseAnonKey,
  );

  runApp(const MyApp());
}

Future<void> _loadEnvFile() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (error) {
    debugPrint('Runtime env file not loaded: $error');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartDrive',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF004299)),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService.authChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Authentication error: ${snapshot.error}'),
            ),
          );
        }
        final user = snapshot.data;
        if (user != null) {
          if (!user.emailVerified) {
            return VerifyEmailScreen(user: user);
          }
          return const Homepage();
        }
        return const Login();
      },
    );
  }
}
