import 'package:flutter/material.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Read our",
            style: TextStyle(
                color: context.theme.greyColor,
                height: 1.5,
                fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: " Privacy Policy",
                style: TextStyle(
                  color: context.theme.blueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ". Tap 'Agree and continue' to accept the",
              ),
              TextSpan(
                text: " Terms of Service",
                style: TextStyle(
                  color: context.theme.blueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
      ),
    );
  }
}
