import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final Widget icon;
  final String label;
  final TextEditingController controller;

  const InputText({super.key, required this.icon, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 10),
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.blue),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              focusColor: Colors.blue,
              labelStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
              ),
              suffixIcon: icon,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
            ),
          ),
        ));
  }
}
