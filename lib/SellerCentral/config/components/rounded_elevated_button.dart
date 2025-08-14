import 'package:flutter/material.dart';

class RoundedElevatedButton extends StatelessWidget {
  RoundedElevatedButton(
      {super.key, required this.text, required this.onPressed});

  String text;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 18),
          foregroundColor: Colors.green),
      child: Text(text),
    );
  }
}
