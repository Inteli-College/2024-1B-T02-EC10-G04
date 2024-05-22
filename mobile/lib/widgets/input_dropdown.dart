import 'package:flutter/material.dart';

class RoleDropdown extends StatefulWidget {
  const RoleDropdown({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RoleDropdownState createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  String? selectedRole;
  final List<String> roles = ['Admin', 'User', 'Guest'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
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