import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hollat/login/data/models/reloadcaptcha/captcha.dart';

class CustomCaptcha extends StatelessWidget {
  final Captcha captcha;

  const CustomCaptcha({super.key, required this.captcha});

  @override
  Widget build(BuildContext context) {
    //Extract the BAse64 data after the coma
    final base64String = captcha.img.split(',').last;
    try {
      //Decode the Base64 string
      final bytes = base64Decode(base64String);
      return Image.memory(
        bytes,
        gaplessPlayback: true,
        fit: BoxFit.contain,
        height: 40,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) return child;
          return frame == null ? const CircularProgressIndicator() : child;
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
