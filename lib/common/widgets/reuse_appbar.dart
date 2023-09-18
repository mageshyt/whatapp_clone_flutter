import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class ReuseableAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isCenterTitle;
  final String? subText;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const ReuseableAppbar({
    super.key,
    required this.title,
    this.isCenterTitle = true,
    this.subText,
    this.actions,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
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
          if (subText != null) const SizedBox(height: 5),
          if (subText != null)
            Text(
              subText!,
              style: TextStyle(
                color: context.theme.authAppbarTextColor,
                fontSize: 14,
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
        if (actions == null)
          CustomIconButton(
            icon: Icons.more_vert,
            onPressed: () {},
            color: context.theme.greyColor,
          ),
        ...actions!
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
