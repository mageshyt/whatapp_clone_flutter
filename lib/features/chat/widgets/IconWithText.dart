import 'package:flutter/material.dart';
import 'package:whatapp_clone/constants/colors.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconWithText({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: ThemeColors.greenDark,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ThemeColors.greenDark,
            ),
          ),
        ],
      ),
    );
  }
}
