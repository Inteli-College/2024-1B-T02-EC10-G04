import 'package:flutter/material.dart';
import 'package:mobile/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:mobile/colors/custom.dart';

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

class OnboardingPage extends StatelessWidget {
  final PageController controller;
  final String logoPath;
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.controller,
    required this.logoPath,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logoPath,
                height: constraints.maxHeight * 0.14,
              ),
              const SizedBox(height: 16),
              Image.asset(
                imagePath,
                height: constraints.maxHeight * 0.4,
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: CustomColors.secondary, // Background color
                  borderRadius: BorderRadius.circular(16), // Border radius
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: const WormEffect(
                        dotColor: Colors.grey,
                        activeDotColor: CustomColors.white100,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.white100),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: CustomColors.white100,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      icon: const Icon(Icons.arrow_forward),
                      label: 'Next',
                      receivedColor: CustomColors.primary,
                      onPressed: () {
                        if (controller.page == 2) {
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //     builder: (context) => {LoginScreen()},
                          //   ),
                          // );
                        } else {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      isEnabled: false,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
