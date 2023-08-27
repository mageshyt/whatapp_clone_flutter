import 'package:flutter/material.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class AuthAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Text(
        "Enter your phone number",
        style: TextStyle(
          color: context.theme.authAppbarTextColor,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.arrow_back, color: context.theme.greyColor),
        constraints: const BoxConstraints(minWidth: 40),
        splashRadius: 22,
        iconSize: 22,
        padding: EdgeInsets.zero,
        splashColor: Colors.transparent,
        color: ThemeColors.greenDark,
      ),
      actions: [
        IconButton.filled(
          onPressed: () {},
          icon: Icon(Icons.more_vert, color: context.theme.greyColor),
          constraints: const BoxConstraints(minWidth: 40),
          splashRadius: 22,
          iconSize: 22,
          padding: EdgeInsets.zero,
          splashColor: Colors.transparent,
          color: ThemeColors.greenDark,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
