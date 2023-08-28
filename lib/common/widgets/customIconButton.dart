import 'package:flutter/material.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double? iconSize;
  final double? minWidth;
  final Color? iconsColor;
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.iconSize,
    this.minWidth,
    this.iconsColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: iconsColor ?? context.theme.greyColor),
      constraints: BoxConstraints(minWidth: minWidth ?? 40),
      splashRadius: 22,
      iconSize: iconSize ?? 22,
      padding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      color: color ?? ThemeColors.greenDark,
    );
  }
}
