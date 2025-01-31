import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';

class CustomStatusButton extends StatelessWidget {
  final String text;

  const CustomStatusButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsLight.whiteColor,
        foregroundColor: AppColorsLight.redColor,
        side: BorderSide(color: AppColorsLight.redColor),
        // Optional: border color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Corner radius
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 10), // Adjust padding as necessary
      ),
      onPressed: () {},
      child: Text(text, style: const TextStyle(
            fontSize: FontsSize.font_16,
            fontFamily: 'neo_sans_medium',
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
