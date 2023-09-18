import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/welcome/widgets/PrivacyAndTerms.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/features/welcome/widgets/languageButton.dart';
import 'package:whatapp_clone/routers/router.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class Welcome_screen extends StatelessWidget {
  const Welcome_screen({super.key});
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => const Welcome_screen());
  }

  navigateToLogin(context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.login, (route) => true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: context.theme.circleImageColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Expanded(
          child: Column(
            children: [
              const Text(
                'Welcome to WhatsApp',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const PrivacyAndTerms(),
              CustomElevatedButton(
                label: 'AGREE AND CONTINUE',
                onPressed: () => navigateToLogin(context),
                text_color: Colors.black,
              ),
              const SizedBox(height: 20),
              const LanguageButton()
            ],
          ),
        ),

        // Agree and continue button
      ]),
    );
  }
}
