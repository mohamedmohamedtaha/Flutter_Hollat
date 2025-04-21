import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/global/theme/app_color/app_color_dark.dart';

class AppThemes {
  static final lightThemeData = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColorsLight.scaffoldBackgroundColor,
      primaryColor: AppColorsLight.primaryColor,
      colorScheme: ColorScheme.light(
        primary: AppColorsLight.primaryColor,
        secondary: Colors.amber,
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColorsLight.primaryColor,
          foregroundColor: AppColorsLight.whiteColor),
      textTheme:
          TextTheme(bodyMedium: TextStyle(color: AppColorsLight.blackColor)),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              // backgroundColor:  WidgetStateProperty.all(AppColorsLight.primaryColor),
              //  foregroundColor:  WidgetStateProperty.all(AppColorsLight.whiteColor)
              )));

  static final darkThemeData = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColorsDark.primaryColor,
      primaryColor: AppColorsDark.scaffoldBackgroundColor,
      colorScheme: ColorScheme.dark(
          primary: Colors.blueGrey, secondary: Colors.tealAccent),
      textTheme:
          TextTheme(bodyMedium: TextStyle(color: AppColorsDark.blackColor)),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColorsDark.primaryColor,
          foregroundColor: AppColorsDark.primaryColor),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              // backgroundColor:  WidgetStateProperty.all(AppColorsLight.primaryColor),
              //  foregroundColor:  WidgetStateProperty.all(AppColorsLight.whiteColor)
              )));
}
