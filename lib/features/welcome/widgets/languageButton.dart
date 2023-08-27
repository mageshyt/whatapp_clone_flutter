import 'package:flutter/material.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});
  showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              // top underline icons
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: ThemeColors.greyBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // title and close icon
              const SizedBox(height: 20),

              Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon:
                          const Icon(Icons.close, color: ThemeColors.greyDark)),
                  const SizedBox(width: 10),
                  const Text(
                    'Choose a language',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              Divider(
                thickness: .5,
                color: context.theme.greyColor!.withOpacity(.3),
              ),

              // list of languages
              RadioListTile(
                value: true,
                groupValue: true,
                onChanged: (value) {},
                title: const Text('English'),
                activeColor: ThemeColors.greenDark,
                subtitle: Text(
                  "(phone's language)",
                  style: TextStyle(
                    color: context.theme.greyColor,
                  ),
                ),
              ),

              RadioListTile(
                value: true,
                groupValue: false,
                onChanged: (value) {},
                title: const Text(
                  'Hindi',
                ),
                activeColor: ThemeColors.greenDark,
                subtitle: Text(
                  "(फ़ोन की भाषा)",
                  style: TextStyle(
                    color: context.theme.greyColor,
                  ),
                ),
              ),
              RadioListTile(
                value: true,
                groupValue: false,
                onChanged: (value) {},
                title: const Text('Tamil'),
                activeColor: ThemeColors.greenDark,
                subtitle: Text(
                  "(தொலைபேசியின் மொழி)",
                  style: TextStyle(
                    color: context.theme.greyColor,
                  ),
                ),
              )
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.langBgColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => showBottomSheet(context),
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: context.theme.langHightlightColor,
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
                color: ThemeColors.greenDark,
              ),
              SizedBox(width: 10),
              Text(
                'English',
                style: TextStyle(
                  color: ThemeColors.greenDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.keyboard_arrow_down,
                color: ThemeColors.greenDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
