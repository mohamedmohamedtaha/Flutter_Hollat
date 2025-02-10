import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final String? fontFamily;
  final int? maxLines;

  const CustomText(
      this.text, {
        super.key,
        this.style,
        this.color,
        this.backgroundColor,
        this.fontSize,
        this.fontWeight,
        this.textAlign,
        this.overflow,
        this.fontFamily,
        this.maxLines
      });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);  return Text(text,
      style: (style ?? theme.textTheme.bodyMedium)?.copyWith(
        color: color ?? theme.textTheme.bodyMedium?.color,
        backgroundColor: backgroundColor ?? AppColorsLight.transparentColor,
        fontSize: fontSize ?? FontsSize.font_11,
        fontWeight: fontWeight,
        fontFamily: fontFamily ?? 'Neo Sans',
      ),
      maxLines: maxLines ,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
