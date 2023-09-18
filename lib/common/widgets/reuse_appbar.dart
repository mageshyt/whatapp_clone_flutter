import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class ReuseableAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isCenterTitle;

  const ReuseableAppbar({
    super.key,
    required this.title,
    this.isCenterTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: context.theme.authAppbarTextColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
      centerTitle: isCenterTitle,
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
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
