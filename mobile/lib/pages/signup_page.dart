import 'package:flutter/material.dart';
import 'package:mobile/classes/colors.dart';
import 'package:mobile/widgets/custom_button.dart';
import 'package:mobile/widgets/input_text.dart';
import 'package:mobile/widgets/modal.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back),
                        color: AppColors.black50,
                        tooltip: 'Back',
                        iconSize: 24.0,
                      ),
                      const Text(
                        'Create an account!',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.black50,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Please enter your details',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.black50,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 24),
                      SizedBox(
                        width: constraints.maxWidth * 0.5,
                        height: constraints.maxHeight * 0.14,
                        child: Image.asset(
                          'assets/images/logo_icon.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 24),
                      InputText(
                        controller: _emailController,
                        label: 'Name',
                        icon: const Icon(null),
                      ),
                      const SizedBox(height: 8),
                      InputText(
                        controller: _emailController,
                        label: 'E-mail',
                        icon: const Icon(Icons.email),
                      ),
                      const SizedBox(height: 8),
                      InputText(
                        controller: _passwordController,
                        label: 'Password',
                        icon: const Icon(Icons.lock),
                        //isPassword: true,
                      ),
                      const SizedBox(height: 32),
                      CustomButton(
                        icon: const Icon(Icons.arrow_forward),
                        label: 'Next',
                        receivedColor: AppColors.secondary,
                        onPressed: () {
                          _showModal(context);
                        },
                        isEnabled: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Have an account?",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.black50)),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/login');
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Additional form fields here
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void _showModal(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5), // Semitransparent background
    builder: (BuildContext context) {
      return const Modal(
        title: 'Account created successfully',
        description:
            'A confirmation code has been sent to your registration email.',
        icon: Icons.check_circle,
        iconColor: AppColors.success,
      );
    },
  );
}
