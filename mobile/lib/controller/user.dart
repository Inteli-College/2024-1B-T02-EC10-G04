import 'package:flutter/material.dart';
import 'package:mobile/logic/show_modal.dart';
import 'package:mobile/models/colors.dart';
import 'package:mobile/services/user.dart';

class UserController {
  final UserService userService;

  UserController({required this.userService});

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      final response = await userService.login(email, password);

      if (response.isNotEmpty) {
        showModal(
            // ignore: use_build_context_synchronously
            context,
            "Login success!",
            "You’ve successfully logged in. Enjoy your seamless experience with our service. ",
            Icons.check,
            AppColors.success,
            "/orders");
        return;
      }
      showModal(
          // ignore: use_build_context_synchronously
          context,
          "Oops! Something Went Wrong",
          "Incorrect email or password. Please double-check your credentials and try again.",
          Icons.error,
          AppColors.error,
          "");

      // Handle login success
    } catch (e) {
      // Handle login failure
    }
  }

  Future<void> signup(
      BuildContext context, String name, String email, String password) async {
    try {
      final response = await userService.signup(name, email, password);

      if (response.isNotEmpty) {
        showModal(
            // ignore: use_build_context_synchronously
            context,
            "Login success!",
            "You’ve successfully logged in. Enjoy your seamless experience with our service. ",
            Icons.check,
            AppColors.success,
            "/orders");
        return;
      }
      showModal(
          // ignore: use_build_context_synchronously
          context,
          "Oops! Something Went Wrong",
          "Incorrect name, email, or password. Please double-check your credentials and try again.",
          Icons.error,
          AppColors.error,
          "");

      // Handle login success
    } catch (e) {
      // Handle login failure
    }
  }
}
