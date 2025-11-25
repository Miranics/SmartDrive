import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartdrive/config/runtime_env.dart';
import 'package:smartdrive/core/theme/app_theme.dart';
import 'package:smartdrive/features/auth/presentation/providers/auth_providers.dart';
import 'package:smartdrive/features/auth/presentation/pages/login_page.dart';
import 'package:smartdrive/features/auth/presentation/pages/signup_page.dart';
import 'package:smartdrive/firebase_options.dart';
import 'package:smartdrive/screens/homepage.dart';
import 'package:smartdrive/screens/WelcomePage.dart';
import 'package:smartdrive/screens/tips_page.dart';
import 'package:smartdrive/screens/verify_email.dart';
import 'package:smartdrive/screens/provisional_exam.dart';
import 'package:smartdrive/screens/QuizPage.dart';
import 'package:smartdrive/screens/progress_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _loadEnvFile();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: RuntimeEnv.supabaseUrl,
    anonKey: RuntimeEnv.supabaseAnonKey,
  );

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _loadEnvFile() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (error) {
    debugPrint('Runtime env file not loaded: $error');
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartDrive',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGate(),
        '/homepage': (context) => const Homepage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/welcome': (context) => const Welcomepage(),
        '/provisional_exam': (context) => ProvisionalExamPage(),
        '/quiz': (context) => Quizpage(),
        '/progress': (context) => const ProgressScreen(),
        '/tips': (context) => const PracticalTipsPage(),
      },
    );
  }
}

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (userEntity) {
        if (userEntity != null) {
          if (!userEntity.emailVerified) {
            // Temporary: Get Firebase User for VerifyEmailScreen
            final firebaseUser = ref.read(firebaseAuthProvider).currentUser;
            if (firebaseUser != null) {
              return VerifyEmailScreen(user: firebaseUser);
            }
          }
          // Authenticated and verified: show WelcomePage
          return const Welcomepage();
        }
        // Not authenticated: show Homepage
        return const Homepage();
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text('Authentication error: $error'),
        ),
      ),
    );
  }
}

// Old code removed below - AuthGate now uses Riverpod
