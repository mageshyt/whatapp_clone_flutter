import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:whatapp_clone/common/helper/show_alert_dialog.dart';
import 'package:whatapp_clone/features/auth/pages/opt_view.dart';
import 'package:whatapp_clone/routers/router.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  void signInWithPhone(BuildContext context, String phone) async {
    try {
      debugPrint(phone);
      // verify the phone
      await auth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            throw Exception(e.message);
          },
          // once the code sent then posh to otp screen

          codeSent: ((String verificationId, int? resendToken) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.verification,
              arguments: {
                'phoneNumber': phone,
                "verificationId": verificationId
              },
              (route) => true,
            );
          }),
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context: context, content: e.message.toString());
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String OTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: OTP);
      await auth.signInWithCredential(credential);

      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.userInformation, (route) => false);
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context: context, content: e.message.toString());
    }
  }
}
