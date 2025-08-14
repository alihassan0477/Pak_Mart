import 'package:flutter/material.dart';

class CallSnackbar {
  void callSnakBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 3), // Optional: Adjust duration
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Handle undo action
          },
        ),
      ),
    );
  }
}
