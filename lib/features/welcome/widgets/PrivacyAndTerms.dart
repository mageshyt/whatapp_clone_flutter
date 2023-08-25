import 'package:flutter/material.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(text: "Read our", children: [
          TextSpan(
            text: " Privacy Policy",
            style: TextStyle(
              color: Color(0xFF00A884),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ". Tap 'Agree and continue' to accept the",
          ),
          TextSpan(
            text: " Terms of Service",
            style: TextStyle(
              color: Color(0xFF00A884),
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
    );
  }
}
