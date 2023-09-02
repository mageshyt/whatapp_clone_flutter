import 'package:flutter/material.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

ThemeData darkTheme() {
  
  
  
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      backgroundColor: ThemeColors.backgroundDark,
      hintColor: ThemeColors.greyLight,
      scaffoldBackgroundColor: ThemeColors.backgroundDark,
      extensions: [CustomThemeExtension.darkMode],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColors.greenDark,
            foregroundColor: ThemeColors.backgroundDark,
            splashFactory: NoSplash.splashFactory,
            elevation: 0,
            shadowColor: Colors.transparent),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ThemeColors.greyBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        modalBackgroundColor: ThemeColors.backgroundDark,
      ),
      dialogBackgroundColor: ThemeColors.greyBackground,
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ));
}
