import 'package:flutter/material.dart';
import 'package:mobile/widgets/navbar.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Go Medicine',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      bottomNavigationBar: const NavBarContainer(),
    ),
  ));
}
