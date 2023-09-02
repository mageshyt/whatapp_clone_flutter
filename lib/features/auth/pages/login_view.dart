import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/common/helper/show_alert_dialog.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/features/auth/controllers/auth_controller.dart';
import 'package:whatapp_clone/features/auth/pages/opt_view.dart';
import 'package:whatapp_clone/common/widgets/reuse_appbar.dart';
import 'package:whatapp_clone/features/auth/widgets/custom_text_field.dart';
import 'package:whatapp_clone/routers/router.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => const LoginView());
  }

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
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
      },
      showPhoneCode: true,
      favorite: ['+91', 'IN'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        flagSize: 22,
        backgroundColor: Theme.of(context).backgroundColor,
        inputDecoration: InputDecoration(
            labelStyle: TextStyle(color: context.theme.greyColor),
            prefixIcon:
                const Icon(Icons.language, color: ThemeColors.greenDark),
            hintText: "Search Country code or name",
            hintStyle: TextStyle(color: context.theme.greyColor),
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: context.theme.greyColor!.withOpacity(0.2)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.greenDark, width: 2),
            )),
      ),
    );
  }

  void sendPhoneCode() {
    // if no country is selected
    if (country == null) {
      showAlertDialog(
        context: context,
        title: "Country not selected",
        content: "Please pick a country",
      );
      return;
    }

    // if phone number is empty

    else if (phoneController.text.isEmpty || phoneController.text.length < 9) {
      showAlertDialog(
        context: context,
        content: "Please enter your phone number",
      );
      return;
    }

    ref.read(authControllerProvider).singInWithPhone(
        context, '+${country!.phoneCode}${phoneController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReuseableAppbar(
        title: "Enter your phone number",
      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (country != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: context.theme.greyColor!.withOpacity(0.2),
                  ),
                  child: Text(
                    "+${country!.phoneCode}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
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
        const SizedBox(height: 15),
        Text(
          "Carrier changes may apply",
          style: TextStyle(color: context.theme.greyColor),
        )
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        label: "NEXT",
        onPressed: sendPhoneCode,
        width: 90,
      ),
    );
  }
}
