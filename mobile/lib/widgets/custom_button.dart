import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onPressed;
  bool isEnabled;
  final Color receivedColor;
  final double minWidth;
  final double height;

  CustomButton({
    super.key,
    required this.receivedColor,
    required this.isEnabled,
    required this.label,
    required this.onPressed,
    this.minWidth = double.infinity, 
    this.height = 50,
    this.icon = const Icon(Icons.arrow_forward),
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = isEnabled ? receivedColor : Colors.grey;

    return MaterialButton(
      onPressed: isEnabled ? onPressed : null,
      color: buttonColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      minWidth: minWidth,
      height: height,
      child: Text(label,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          )),
    );
  }
}
