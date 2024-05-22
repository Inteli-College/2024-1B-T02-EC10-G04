import 'package:flutter/material.dart';
import 'package:mobile/colors/custom.dart';
import 'package:mobile/pages/login_page.dart';
import 'package:mobile/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
                      effect: const ScrollingDotsEffect(
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
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        } else {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      isEnabled: true,
                    ),
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
