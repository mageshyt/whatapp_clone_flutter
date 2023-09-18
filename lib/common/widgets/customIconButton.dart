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
  final Color? backgroundColor;
  final BoxBorder? border;
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.iconSize,
    this.minWidth,
    this.iconsColor,
    this.backgroundColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: border,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon,
            color:
                iconsColor ?? Theme.of(context).appBarTheme.iconTheme!.color),
        constraints: BoxConstraints(
          minWidth: minWidth ?? 45,
          minHeight: minWidth ?? 45,
        ),
        splashRadius: (minWidth ?? 40) - 22,
        iconSize: iconSize ?? 22,
        padding: EdgeInsets.zero,
        splashColor: Colors.transparent,
        color: color ?? ThemeColors.greenDark,
      ),
    );
  }
}
