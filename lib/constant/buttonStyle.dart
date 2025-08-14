import 'package:flutter/material.dart';

final rectanuglarButton = ElevatedButton.styleFrom(
  fixedSize: const Size(150, 30),
  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
);

final outlinedButton = OutlinedButton.styleFrom(
    foregroundColor: Colors.green,
    side: const BorderSide(
      color: Colors.green,
    ));
