import 'package:flutter/material.dart';

class TennisField extends StatelessWidget {
  final String image;
  final String text;

  const TennisField({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          children: [
            AspectRatio(
              aspectRatio: 16 / 9, // Adjust aspect ratio as needed
              child: Image.asset(image),
            ), // Assuming images are loaded from assets
            SizedBox(height: 20), // Add spacing between image and text
            Expanded(child: Text(text)), // Wrap text in Expanded
          ],
        ),
      ),
    );
  }
}
