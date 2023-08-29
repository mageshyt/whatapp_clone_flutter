import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/common.dart';
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
      leading: CustomIconButton(
        icon: Icons.arrow_back,
        onPressed: () => Navigator.of(context).pop(),
        color: context.theme.greyColor,
      ),
      actions: [
        CustomIconButton(
          icon: Icons.more_vert,
          onPressed: () {},
          color: context.theme.greyColor,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
