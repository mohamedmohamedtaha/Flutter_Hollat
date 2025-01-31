import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final String? fontFamily;

  const CustomText(
      this.text, {
        super.key,
        this.style,
        this.color,
        this.fontSize,
        this.fontWeight,
        this.textAlign,
        this.overflow,
        this.fontFamily
      });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);  return Text(

      text,
      style: (style ?? theme.textTheme.bodyMedium)?.copyWith(
        color: color ?? theme.textTheme.bodyMedium?.color,
        fontSize: fontSize ?? FontsSize.font_18,
        fontWeight: fontWeight,
        fontFamily: fontFamily ?? 'Neo Sans',
      ),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
