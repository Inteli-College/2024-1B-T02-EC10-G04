// lib/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/services/user.dart';

class UserController {
  final UserService userService;

  UserController({required this.userService});

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      final response = await userService.login(email, password);

      // Handle login success
      Navigator.of(context).pushNamed('/orders');
    } catch (e) {
      // Handle login failure
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Please check your credentials and try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
