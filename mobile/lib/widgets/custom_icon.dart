import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onPressed;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon,
          Text(
            label,
            style: const TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 130, 130, 130),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
