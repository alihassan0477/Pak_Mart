import 'package:flutter/material.dart';
import 'package:pakmart/constant/screensize.dart';

class AppBarTextFeild extends StatelessWidget {
  const AppBarTextFeild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 70,
          left: Screensize(context: context).screenWidth - 370,
          right: 20),
      child: Container(
        width: double.infinity, // Make the container fill the width
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(25), // Optional: Keep rounded corners
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: "Search",
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            suffixIcon: Icon(Icons.mic, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
