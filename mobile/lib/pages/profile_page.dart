import 'package:flutter/material.dart';
import 'package:mobile/models/colors.dart';
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
  late TextEditingController _nameController =
      TextEditingController(text: widget.name);
  late TextEditingController _emailController =
      TextEditingController(text: widget.email);

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
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35.0,
                    backgroundColor: Colors.purple,
                    child: Text('FL'),
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
            const Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 40.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Account Information',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Column(
                children: [
                  InputText(
                    enabled: false,
                    icon: const Icon(Icons.email),
                    label: 'Name',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 20.0),
                  InputText(
                    enabled: false,
                    icon: const Icon(Icons.lock),
                    label: 'Email',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 60.0),
                  CustomButton(
                    receivedColor: AppColors.secondary,
                    isEnabled: true,
                    label: 'LogOut',
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        )));
  }
}
