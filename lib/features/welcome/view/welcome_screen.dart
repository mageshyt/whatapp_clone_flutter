import 'package:flutter/material.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/features/welcome/widgets/PrivacyAndTerms.dart';
import 'package:whatapp_clone/features/welcome/widgets/customElevatedButton.dart';
import 'package:whatapp_clone/features/welcome/widgets/languageButton.dart';

class Welcome_screen extends StatelessWidget {
  const Welcome_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundDark,
      body: Column(children: [
        // logo
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 10,
              ),
              child: Image.asset(
                'assets/images/circle.png',
                color: const Color(0xFF00A884),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        const Expanded(
          child: Column(
            children: [
              Text(
                'Welcome to WhatsApp',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              PrivacyAndTerms(),
              CustomElevatedButton(),
              SizedBox(height: 20),
              LanguageButton()
            ],
          ),
        ),

        // Agree and continue button
      ]),
    );
  }
}
