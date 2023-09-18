import 'package:flutter/material.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

showLoadingDialog({
  required BuildContext context,
  required String message,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const CircularProgressIndicator(
                  color: ThemeColors.greenDark,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 15,
                      color: context.theme.greyColor,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
