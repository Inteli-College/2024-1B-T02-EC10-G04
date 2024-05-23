import 'package:flutter/material.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/widgets/custom_button.dart';
import 'package:mobile/widgets/input_dropdown.dart';
import 'package:mobile/widgets/input_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateInputs);
    _roleController.addListener(_validateInputs);
    _emailController.addListener(_validateInputs);
    _passwordController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      isButtonEnabled = _emailController.text.isNotEmpty &&
          _nameController.text.isNotEmpty &&
          _roleController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

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
                      const Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                SizedBox(height: 40),
                                Text(
                                  'Create an account!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.black50,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(
                                  'Please enter your details',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.black50,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
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
                      const InputDropdown(),
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
                        onPressed: () {},
                        isEnabled: isButtonEnabled,
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
