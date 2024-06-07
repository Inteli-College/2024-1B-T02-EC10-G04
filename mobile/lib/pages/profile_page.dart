import 'package:flutter/material.dart';
import 'dart:math';
import 'package:mobile/logic/local_storage.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/widgets/navbar.dart';
import 'package:mobile/widgets/input_text.dart';
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
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _nameController =
      TextEditingController(text: widget.name);
  late final TextEditingController _emailController =
      TextEditingController(text: widget.email);

  String getInitials(String name) {
    List<String> nameParts = name.split(' ');
    String initials = '';
    if (nameParts.isNotEmpty) {
      initials = nameParts.map((part) => part[0]).take(2).join();
    }
    return initials.toUpperCase();
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _logout() async {
      await LocalStorageService().cleanValues();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }

    String initials = getInitials(widget.name);
    Color avatarColor = getRandomColor();

    return Scaffold(
      bottomNavigationBar: const NavBarContainer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.only(top: 60.0, bottom: 15.0, left: 20.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: AppColors.black50,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      'Here you can see your personal information',
                      style: TextStyle(
                        color: AppColors.black50,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35.0,
                    backgroundColor: avatarColor,
                    child: Text(
                      initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    widget.role,
                    style: const TextStyle(
                      color: AppColors.black50,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 40.0),
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
                    obscureText: false,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 20.0),
                  InputText(
                    enabled: false,
                    icon: const Icon(Icons.lock),
                    label: 'Email',
                    obscureText: false,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 60.0),
                  CustomButton(
                    receivedColor: AppColors.secondary,
                    isEnabled: true,
                    label: 'LogOut',
                    onPressed: () async {
                      _logout();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
