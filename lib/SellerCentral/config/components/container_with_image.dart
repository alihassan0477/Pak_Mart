import 'package:flutter/material.dart';
import 'package:pakmart/SellerCentral/config/components/rounded_elevated_button.dart';

class ContainerWithImage extends StatelessWidget {
  const ContainerWithImage({
    super.key,
    required this.title,
    required this.image_url,
    this.onPressed,
    required this.ondeletePressed,
  });

  final String title;
  final String image_url;
  final VoidCallback? onPressed;
  final VoidCallback? ondeletePressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 300, // Box width (adjust as needed)
        height: 200, // Box height (adjust as needed)
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Rounded corners (optional)
          // Background color of the box
          border: Border.all(color: Colors.green),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                child: Image.network(
                  image_url, // Replace with actual image URL
                  height: 150, // Image height
                  fit: BoxFit.cover, // Image fitting
                ),
              ),
            ),
            // Product Title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title, // Replace with actual product title
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            RoundedElevatedButton(text: "Delete", onPressed: ondeletePressed!),
          ],
        ),
      ),
    );
  }
}
