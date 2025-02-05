import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/font/fonts_size.dart';
import 'package:hollat/easy_localization/app_lang.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool enabled;
  final ButtonStyle? style;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Widget? child;
  final bool? directWriting;
  final Color? color;

  const CustomTextButton(
      {super.key,
        required this.text,
        required this.onPressed,
        this.enabled = true,
        this.style,
        this.padding,
        this.textStyle,
        this.child,
      this.directWriting,
      this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40.0,
        child: TextButton(
          style: (style ?? ElevatedButton.styleFrom()).merge(
              TextButton.styleFrom(
               // backgroundColor: AppColorsLight.grayColor,
                  foregroundColor: color ?? AppColorsLight.blackColor,
                  minimumSize: const Size(double.infinity, 40.0),
                  padding: padding,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)))),
          onPressed: enabled ? onPressed : null,

          child: child ??
              Align(
                  alignment: directWriting != null ? Alignment.center  :
                  (AppLang.currentLanguage(context) == 'ar'
                      ? Alignment.centerRight
                      : Alignment.centerLeft),
                  child: Text(
                    text,
                    style: textStyle ??
                        const TextStyle(fontSize: FontsSize.font_13,),
                  )),
        ));
  }
}
