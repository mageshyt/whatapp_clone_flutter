import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/common/widgets/reuse_appbar.dart';
import 'package:whatapp_clone/features/auth/controllers/auth_controller.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPScreen extends ConsumerWidget {
  final String verificationId;
  final String phoneNumber;

  const OTPScreen(
      {super.key, required this.verificationId, required this.phoneNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const ReuseableAppbar(
        title: "Verification Code",
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          // ------------info text--------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text:
                    "you've tried to register $phoneNumber. wait before requesting an SMS or call with your code.",
                style: TextStyle(color: context.theme.greyColor, height: 1.5),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.of(context).pop(),
                    text: "\n Wrong number ?",
                    style: const TextStyle(
                        color: ThemeColors.greenDark,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          OtpTextField(
            numberOfFields: 6,
            borderColor: ThemeColors.greenDark,
            fieldWidth: 45,
            enabledBorderColor: ThemeColors.greyLight,
            focusedBorderColor: ThemeColors.backgroundLight,

            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) {
              debugPrint("verifying the otp");
              ref
                  .read(authControllerProvider)
                  .verifyOTP(context, verificationId, verificationCode);
            }, // end onSubmit
          ),
          const SizedBox(height: 20),

          // ------------info text 2 --------
          Text(
            "Enter 6-digit code",
            style: TextStyle(color: context.theme.greyColor),
          )
        ],
      ),
    );
  }
}
