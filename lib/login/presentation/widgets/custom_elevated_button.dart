import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool enabled;
  final ButtonStyle? style;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Widget? child;
  final Color? color;

  const CustomElevatedButton(
      {super.key,
        required this.text,
        required this.onPressed,
        this.enabled = true,
        this.style,
        this.padding,
        this.textStyle,
        this.child,
        this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: (style ?? ElevatedButton.styleFrom()).merge(
          ElevatedButton.styleFrom(
              backgroundColor: enabled
                  ? color ?? AppColorsLight.primaryColor
                  : AppColorsLight.grayColor,
              foregroundColor: AppColorsLight.whiteColor,
              minimumSize: const Size(double.infinity, 40.0),
              padding: padding,
              //padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
      onPressed: enabled ? onPressed : null,
      child: child ??
          Text(
            text,
            style: textStyle ??
                const TextStyle(
                    fontSize: FontsSize.font_22, fontWeight: FontWeight.w600),
          ),
    );
  }
}
