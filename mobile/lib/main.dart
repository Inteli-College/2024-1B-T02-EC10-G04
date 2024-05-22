import 'package:flutter/material.dart';
import 'package:mobile/pages/login_page.dart';
import 'package:mobile/pages/logo_page.dart';
import 'package:mobile/pages/onboarding_page.dart';
import 'package:mobile/pages/signup_page.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}
