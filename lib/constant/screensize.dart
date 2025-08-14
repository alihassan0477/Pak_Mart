import 'package:flutter/material.dart';

class Screensize {
  Screensize({required this.context});

  BuildContext context;

  double get screenheight => MediaQuery.of(context).size.height;
  double get screenWidth => MediaQuery.of(context).size.width;
}
