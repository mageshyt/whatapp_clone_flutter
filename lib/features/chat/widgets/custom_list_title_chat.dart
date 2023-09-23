import 'package:flutter/material.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class ChatCustomListTitle extends StatelessWidget {
  const ChatCustomListTitle(
      {Key? key,
      required this.title,
      this.trailing,
      required this.leading,
      this.subTitle})
      : super(key: key);
  final String title;
  final IconData leading;
  final String? subTitle;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.fromLTRB(25, 5, 10, 5),
      title: Text(title),
      subtitle: subTitle != null
          ? Text(subTitle!,
              style: TextStyle(
                color: context.theme.greyColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ))
          : null,
      leading: Icon(leading),
      trailing: trailing,
    );
  }
}
