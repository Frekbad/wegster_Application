import 'package:flutter/material.dart';
import 'package:wegster_application/themes/dm_color_theme.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

class AppThemes {
  static final Map<AppTheme, ThemeData> appThemeData = {
    // Light Theme
    AppTheme.lightTheme: ThemeData(
      scaffoldBackgroundColor: DMColors.backgroundColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: DMColors.backgroundwhiteColor,
        secondary: DMColors.backgroundColor,
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
            color: DMColors.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'ProximaNova'),
      ),
      iconTheme: const IconThemeData(
        color: DMColors.blackColor,
      ),
    ),

    // Dark Theme
    AppTheme.darkTheme: ThemeData(
      scaffoldBackgroundColor: DMColors.googleColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: DMColors.lightDarkColor,
        secondary: DMColors.lightDarkColor,
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
            color: DMColors.backgroundwhiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'ProximaNova'),
      ),
      iconTheme: const IconThemeData(
        color: DMColors.backgroundwhiteColor,
      ),
    ),
  };
}
