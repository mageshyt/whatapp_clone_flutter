import 'package:flutter/material.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    backgroundColor: ThemeColors.backgroundLight,
    scaffoldBackgroundColor: ThemeColors.backgroundLight,
    extensions: [CustomThemeExtension.lightMode],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColors.greenLight,
          foregroundColor: ThemeColors.backgroundLight,
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          shadowColor: ThemeColors.greyBackground),
    ),
  );
}
