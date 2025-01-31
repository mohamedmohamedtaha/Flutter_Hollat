import 'package:flutter/material.dart';
class CustomImage extends StatelessWidget {
  final String imgLink;

  const CustomImage({super.key, required this.imgLink});

  @override
  Widget build(BuildContext context) {
    try {
      return Image.network(
        imgLink,
        loadingBuilder:(context, child, loadingProgress) {
          if(loadingProgress == null)return child;
          return CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded /
            loadingProgress.expectedTotalBytes! :null
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error);
        },
      );
    } catch (e) {
      return const Text('Failed to load captcha image');
    }
  }
}
