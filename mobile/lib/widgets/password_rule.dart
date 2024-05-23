import 'package:flutter/material.dart';

class PasswordRule extends StatelessWidget {
  final String text;
  final String expression;
  final String label;

  PasswordRule({
    Key? key,
    required this.text,
    required this.expression,
    required this.label,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        text.contains(RegExp(expression)) ?
        const Icon(
          Icons.check,
          color: Colors.green,
        ) : const Icon(
          Icons.block_flipped,
          color: Colors.red,
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
