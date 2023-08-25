import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/welcome/widgets/PrivacyAndTerms.dart';
import 'package:whatapp_clone/features/welcome/widgets/languageButton.dart';

class Welcome_screen extends StatelessWidget {
  const Welcome_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111B21),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
         children: [
          // logo
          Align(
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

          const SizedBox(height: 40),

          Column(
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF00A884),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Agree and continue',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const LanguageButton()
            ],
          ),

          // Agree and continue button
        ]),
      ),
    );
  }
}
