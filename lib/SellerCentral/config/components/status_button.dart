import 'package:flutter/material.dart';

class StatusButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onPressed;

  const StatusButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
