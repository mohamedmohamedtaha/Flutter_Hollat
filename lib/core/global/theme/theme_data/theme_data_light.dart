import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_dark.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';

ThemeData getThemeDataLight()=> ThemeData(
  scaffoldBackgroundColor: AppColorsLight.scaffoldBackgroundColor,
    primaryColor: AppColorsLight.primaryColor,
    appBarTheme:  const AppBarTheme(
        color: AppColorsLight.primaryColor
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
           // backgroundColor:  WidgetStateProperty.all(AppColorsLight.primaryColor),
          //  foregroundColor:  WidgetStateProperty.all(AppColorsLight.whiteColor)
        )
    )
);