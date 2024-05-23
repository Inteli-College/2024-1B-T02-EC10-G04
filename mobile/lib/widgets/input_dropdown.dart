import 'package:flutter/material.dart';

class InputDropdown extends StatefulWidget {
  const InputDropdown({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InputDropdownState createState() => _InputDropdownState();
}

class _InputDropdownState extends State<InputDropdown> {
  String? selectedRole;
  final List<String> roles = ['Admin', 'User', 'Guest'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        labelText: 'Role',
      ),
      value: selectedRole,
      icon: const Icon(Icons.arrow_drop_down),
      items: roles.map((role) {
        return DropdownMenuItem<String>(
          value: role,
          child: Text(role),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedRole = value;
        });
      },
    );
  }
}
