import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeColors.greyBackground,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ThemeColors.greyDark,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(
          color: ThemeColors.greyDark,
        ),
      ),
      tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: ThemeColors.greenDark,
            width: 2,
          ),
        ),
        unselectedLabelColor: ThemeColors.greyDark,
        labelColor: ThemeColors.greenDark,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ThemeColors.greenDark,
        foregroundColor: Colors.white,
      ),
      listTileTheme: const ListTileThemeData(
          iconColor: ThemeColors.greyDark,
          tileColor: ThemeColors.backgroundDark),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(ThemeColors.greenDark),
        trackColor: MaterialStateProperty.all(Color(0xFF344047)),
      ));
}
