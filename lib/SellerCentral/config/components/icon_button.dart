import 'package:flutter/material.dart';

class IconButtonComponent extends StatelessWidget {
  IconButtonComponent(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.icon});

  String text;
  IconData icon;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18),
        foregroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
    );
  }
}
