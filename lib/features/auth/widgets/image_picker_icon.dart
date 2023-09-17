import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class ImagePickerIcon extends StatelessWidget {
  final IconData icon;
  final String title;

  final VoidCallback onTap;

  const ImagePickerIcon(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomIconButton(
          icon: icon,
          onPressed: onTap,
          minWidth: 55,
          iconSize: 30,
          iconsColor: ThemeColors.greenDark,
          border: Border.all(
            color: context.theme.greyColor!.withOpacity(0.2),
          ),

          // ------ backgroundColor ------

          backgroundColor: context.theme.greyColor!.withOpacity(0.1),
        ),

        const SizedBox(height: 10),

        // ------ title ------
        Text(
          title,
          style: TextStyle(
            color: context.theme.greyColor,
          ),
        ),
      ],
    );
  }
}
