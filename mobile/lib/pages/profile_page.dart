import 'package:flutter/material.dart';
import 'package:mobile/classes/colors.dart';
import 'package:mobile/widgets/navbar.dart';
import 'package:mobile/widgets/input_text.dart';
import 'package:mobile/widgets/password_rule.dart';
import 'package:mobile/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String role;
  final String email;

  const ProfilePage({
    super.key,
    required this.name,
    required this.role,
    required this.email,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  bool _showContainer = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email);
    _passwordController = TextEditingController();
    _passwordController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showContainer = _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavBarContainer(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.only(
                      top: 60.0, bottom: 15.0, left: 20.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                            color: AppColors.black50,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                      Text(
                        'Here you can see your personal information',
                        style: TextStyle(
                            color: AppColors.black50,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  )),
            ),
            Container(
              padding: const  EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    child: Text('FL'),
                    radius: 35.0,
                    backgroundColor: Colors.purple,
                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                  Text(
                    widget.role,
                    style: const TextStyle(
                        color: AppColors.black50,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  InputText(
                    icon: const Icon(Icons.email),
                    label: 'Email',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20.0),
                  InputText(
                    icon: const Icon(Icons.lock),
                    label: 'Password',
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 20.0),
                  _showContainer
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PasswordRule(
                                expression: r'[A-Z]',
                                label: '1 uppercase letter',
                                text: _passwordController.text,
                              ),
                              PasswordRule(
                                expression: r'[a-z]',
                                label: '1 lowercase letter',
                                text: _passwordController.text,
                              ),
                              PasswordRule(
                                expression: r'[0-9]',
                                label: '1 number',
                                text: _passwordController.text,
                              ),
                              PasswordRule(
                                expression: r'[!@#$%^&*(),.?":{}|<>]',
                                label: '1 special character',
                                text: _passwordController.text,
                              ),
                              PasswordRule(
                                expression: r'^.{8,}$',
                                label: '8 characters',
                                text: _passwordController.text,
                              ),
                            ],
                          ))
                      : const SizedBox(),
                      const SizedBox(height: 20.0),
                      CustomButton(
                        receivedColor: AppColors.secondary,
                        isEnabled: true,
                        label: 'Save',
                        onPressed: () {},
                      )
                ],
              ),
            )
          ],
        )));
  }

}
