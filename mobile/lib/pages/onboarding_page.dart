import 'package:flutter/material.dart';
import 'package:mobile/widgets/card_onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                OnboardingPage(
                  controller: _controller,
                  logoPath: 'assets/images/logo.png',
                  imagePath: 'assets/images/onboarding_1.png',
                  title: 'Welcome to GoMedice',
                  description:
                      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
                ),
                OnboardingPage(
                  controller: _controller,
                  logoPath: 'assets/images/logo.png',
                  imagePath: 'assets/images/onboarding_2.png',
                  title: 'Discover Features',
                  description:
                      'Learn about the various features available in our app that make it easy for you to manage your health and wellness.',
                ),
                OnboardingPage(
                  controller: _controller,
                  logoPath: 'assets/images/logo.png',
                  imagePath: 'assets/images/onboarding_3.png',
                  title: 'Get Started',
                  description:
                      'Sign up today and start experiencing the benefits of our app!',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
