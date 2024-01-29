import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imagePath;

  CustomImage({
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imagePath,
      height: 90.0, // Set the desired height
      width: 93.0, // Set the desired width
      fit: BoxFit.cover, // Adjust the fit based on your needs
      // You can add more properties as needed, such as loadingBuilder, errorBuilder, etc.
    );
  }
}
