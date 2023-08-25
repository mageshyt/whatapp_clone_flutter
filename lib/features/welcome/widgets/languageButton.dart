import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF09141A),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => print('Language'),
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: const Color(0xFF09141A),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.language,
                color: Color(0xFF00A884),
              ),
              SizedBox(width: 10),
              Text(
                'English',
                style: TextStyle(
                  color: Color(0xFF00A884),
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF00A884),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
