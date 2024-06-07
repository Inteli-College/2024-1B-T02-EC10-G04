import 'package:flutter/material.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/pages/login_page.dart';
import 'package:mobile/widgets/card_onboarding.dart';
import 'package:mobile/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'logoPath': 'assets/images/logo.png',
      'imagePath': 'assets/images/onboarding_1.png',
      'title': 'Welcome to GoMedice',
      'description':
          'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
    },
    {
      'logoPath': 'assets/images/logo.png',
      'imagePath': 'assets/images/onboarding_2.png',
      'title': 'Discover Features',
      'description':
          'Learn about the various features available in our app that make it easy for you to manage your health and wellness.',
    },
    {
      'logoPath': 'assets/images/logo.png',
      'imagePath': 'assets/images/onboarding_3.png',
      'title': 'Get Started',
      'description':
          'Sign up today and start experiencing the benefits of our app!',
    },
  ];

  void _nextPage() {
    setState(() {
      if (_currentIndex < _onboardingData.length - 1) {
        _currentIndex++;
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: OnboardingPage(
              logoPath: _onboardingData[_currentIndex]['logoPath']!,
              imagePath: _onboardingData[_currentIndex]['imagePath']!,
              title: _onboardingData[_currentIndex]['title']!,
              description: _onboardingData[_currentIndex]['description']!,
              onNext: _nextPage,
              currentIndex: _currentIndex,
              totalPages: _onboardingData.length,
            ),
          ),
        ],
      ),
    );
  }
}
