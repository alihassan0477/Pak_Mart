import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String value;
  final String label;
  final Color valueColor;

  const StatCard({
    super.key,
    required this.icon,
    required this.iconBackgroundColor,
    this.iconColor = Colors.white,
    required this.value,
    required this.label,
    this.valueColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon with colored background
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 16),
            // Value text
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
            const SizedBox(height: 4),
            // Label text
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
