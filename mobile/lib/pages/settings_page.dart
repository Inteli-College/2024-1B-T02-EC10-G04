import 'package:flutter/material.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/widgets/navbar.dart';
import 'package:mobile/widgets/input_text.dart';
import 'package:mobile/widgets/password_rule.dart';
import 'package:mobile/widgets/custom_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _previousPasswordController =
      TextEditingController();
  late TextEditingController _newPasswordController = TextEditingController();
  bool _showContainer = false;

  @override
  void initState() {
    super.initState();
    _previousPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _previousPasswordController.addListener(_onTextChanged);
    _newPasswordController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _previousPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showContainer = _newPasswordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const NavBarContainer(),
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
                        'Settings',
                        style: TextStyle(
                            color: AppColors.black50,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  )),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 40.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        'Update Password',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  InputText(
                    icon: const Icon(Icons.edit),
                    label: 'Previous Password',
                    controller: _previousPasswordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  InputText(
                    icon: const Icon(Icons.edit),
                    label: 'New Password',
                    controller: _newPasswordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  _showContainer
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PasswordRule(
                                expression: r'[A-Z]',
                                label: '1 uppercase letter',
                                text: _newPasswordController.text,
                              ),
                              PasswordRule(
                                expression: r'[a-z]',
                                label: '1 lowercase letter',
                                text: _newPasswordController.text,
                              ),
                              PasswordRule(
                                expression: r'[0-9]',
                                label: '1 number',
                                text: _newPasswordController.text,
                              ),
                              PasswordRule(
                                expression: r'[!@#$%^&*(),.?":{}|<>]',
                                label: '1 special character',
                                text: _newPasswordController.text,
                              ),
                              PasswordRule(
                                expression: r'^.{8,}$',
                                label: '8 characters',
                                text: _newPasswordController.text,
                              ),
                            ],
                          ))
                      : const SizedBox(),
                  const SizedBox(height: 16.0),
                  CustomButton(
                    receivedColor: AppColors.secondary,
                    isEnabled: true,
                    label: 'Submit',
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        )));
  }
}
