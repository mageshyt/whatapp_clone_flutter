import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      backgroundColor: ThemeColors.backgroundLight,
      hintColor: ThemeColors.black,
      scaffoldBackgroundColor: ThemeColors.backgroundLight,
      textTheme: base.textTheme.apply(bodyColor: ThemeColors.black),
      extensions: [CustomThemeExtension.lightMode],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColors.greenLight,
            foregroundColor: ThemeColors.backgroundLight,
            splashFactory: NoSplash.splashFactory,
            elevation: 0,
            shadowColor: Colors.transparent),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ThemeColors.backgroundLight,
        modalBackgroundColor: ThemeColors.backgroundLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
      dialogBackgroundColor: ThemeColors.backgroundLight,
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeColors.greenLight,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ThemeColors.greenDark,
        foregroundColor: Colors.white,
      ),
      listTileTheme: const ListTileThemeData(
          iconColor: ThemeColors.greyDark,
          tileColor: ThemeColors.backgroundLight),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(Color(0xFF83939c)),
        trackColor: MaterialStateProperty.all(Color(0xFFDAFE2)),
      ));
}
