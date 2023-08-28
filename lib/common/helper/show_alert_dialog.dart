import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

showAlertDialog({
  required BuildContext context,
  String? title,
  required String content,
  String? btnText,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        content,
        style: TextStyle(
          fontSize: 15,
          color: context.theme.greyColor,
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              btnText ?? 'OK',
              style: TextStyle(
                fontSize: 15,
                color: context.theme.circleImageColor,
              ),
            ))
      ],
    ),
  );
}
