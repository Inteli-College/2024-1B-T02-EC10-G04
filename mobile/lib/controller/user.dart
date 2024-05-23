// lib/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:mobile/services/user.dart';
import 'package:mobile/widgets/modal.dart';

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
    }
  }
}
