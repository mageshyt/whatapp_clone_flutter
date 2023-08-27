import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/features/auth/widgets/auth_appbar.dart';
import 'package:whatapp_clone/features/auth/widgets/custom_text_field.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:country_picker/country_picker.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final phoneController = TextEditingController();
  Country? country;
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          // ! setState is used to update the UI
          setState(() {
            country = _country;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AuthAppbar(),
      body: Column(children: [
        // info text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text:
                  "WhatsApp will send an SMS message to verify your phone number.",
              style: TextStyle(color: context.theme.greyColor, height: 1.5),
              children: const [
                TextSpan(
                  text: " What's my number?",
                  style: TextStyle(
                      color: ThemeColors.greenDark,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),

        // pick country code
        TextButton(
          onPressed: pickCountry,
          child: Text(
            "pick a country",
            style: TextStyle(
                color: context.theme.blueColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 10),

        // phone number field
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (country != null)
                Text(
                  "+${country!.phoneCode}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomTextField(
                  controller: phoneController,
                  label: "Phone Number",
                  hintText: "Phone Number",
                  keyboardType: TextInputType.name,
                ),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        label: "NEXT",
        onPressed: () {},
        width: 90,
      ),
    );
  }
}
