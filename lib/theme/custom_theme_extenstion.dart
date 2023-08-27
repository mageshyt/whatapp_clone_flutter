import 'package:flutter/material.dart';
import 'package:whatapp_clone/constants/colors.dart';

extension ExtendedTheme on BuildContext {
  CustomThemeExtension get theme {
    return Theme.of(this).extension<CustomThemeExtension>()!;
  }
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color? circleImageColor;
  final Color? greyColor;
  final Color? blueColor;
  final Color? langBgColor;
  final Color? langHightlightColor;
  final Color? authAppbarTextColor;

  const CustomThemeExtension({
    this.circleImageColor,
    this.greyColor,
    this.blueColor,
    this.langBgColor,
    this.langHightlightColor,
    this.authAppbarTextColor,
  });

  static const lightMode = CustomThemeExtension(
    circleImageColor: Color(0xFF25D366),
    greyColor: ThemeColors.greyLight,
    blueColor: ThemeColors.blueLight,
    langBgColor: Color(0xFFF7F8FA),
    langHightlightColor: Color(0xFFE8E8ED),
    authAppbarTextColor: ThemeColors.greenLight,
  );

  static const darkMode = CustomThemeExtension(
    circleImageColor: ThemeColors.greenDark,
    greyColor: ThemeColors.greyDark,
    blueColor: ThemeColors.blueDark,
    langBgColor: Color(0xFF182229),
    langHightlightColor: Color(0xFF09141A),
    authAppbarTextColor: ThemeColors.greenDark,
  );
  @override
  ThemeExtension<CustomThemeExtension> copyWith(
      {Color? circleImageColor,
      Color? greyColor,
      Color? blueColor,
      Color? langBgColor,
      Color? langHightlightColor,
      Color? authAppbarTextColor}) {
    return CustomThemeExtension(
      circleImageColor: circleImageColor ?? this.circleImageColor,
      greyColor: greyColor ?? this.greyColor,
      blueColor: blueColor ?? this.blueColor,
      langBgColor: langBgColor ?? this.langBgColor,
      langHightlightColor: langHightlightColor ?? this.langHightlightColor,
      authAppbarTextColor: authAppbarTextColor ?? this.authAppbarTextColor,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
      covariant ThemeExtension<CustomThemeExtension>? other, double t) {
    // if other is not CustomThemeExtension then return this
    // lerp is used to change the theme
    if (other is! CustomThemeExtension) return this;

    return CustomThemeExtension(
      circleImageColor: Color.lerp(circleImageColor, other.circleImageColor, t),
      greyColor: Color.lerp(greyColor, other.greyColor, t),
      blueColor: Color.lerp(blueColor, other.blueColor, t),
      langBgColor: Color.lerp(langBgColor, other.langBgColor, t),
      langHightlightColor:
          Color.lerp(langHightlightColor, other.langHightlightColor, t),
      authAppbarTextColor:
          Color.lerp(authAppbarTextColor, other.authAppbarTextColor, t),
    );
  }
}
