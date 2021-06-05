import 'package:flutter/material.dart';

import 'color_theme.dart';

const kColorAppbar = Color.fromRGBO(255, 209, 128, 1);

enum AppTheme {
  OrangeLight,
  OrangeDark,
  BlueLight,
}

final appThemeData = {
  AppTheme.OrangeLight: ThemeData(
    primaryColor: primaryOrange,
    accentColor: darkColor,
    colorScheme: ColorScheme.light(
      primary: primaryOrange,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
  ),
  AppTheme.OrangeDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryDOrange,
    accentColor: darkColor,
    colorScheme: ColorScheme.dark(
      primary: primaryOrange,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
  ),
  AppTheme.BlueLight: ThemeData(
    primaryColor: primaryBlue,
    accentColor: darkColor,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
  ),
};
