import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:whatapp_clone/common/helper/show_alert_dialog.dart';
import 'package:whatapp_clone/common/repositories/common_firebase_storge_repo.dart';
import 'package:whatapp_clone/models/user_model.dart';

import 'package:whatapp_clone/routers/router.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage = FirebaseStorage.instance;

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

// ---- function to get current user---
  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user;
    final userInfo =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();

    if (userInfo.data() == null) return user;
    user = UserModel.fromMap(userInfo.data()!);
    return user;
  }

  // ---- function to save user to firebase0000
  void saveUserDataToFirebase(
      {required String name,
      required var profileImage,
      required ProviderRef ref,
      required BuildContext context,
      required bool mounted}) async {
    try {
      String uid = auth.currentUser!.uid;
      String profileImageUrl = profileImage is String ? profileImage : '';

      // if profile image then upload it
      if (profileImage != null && profileImage is! String) {
        profileImageUrl = await ref
            .read(firebaseStorageProvider)
            .storeFileToFirebase('profileImage/$uid', profileImage);
      }

      // ---- upload it to the collection ----
      UserModel user = UserModel(
          name: name,
          uid: uid,
          profilePhotoUrl: profileImageUrl,
          isOnline: true,
          phoneNumber: auth.currentUser!.phoneNumber ?? '',
          groupId: []);

      debugPrint('user ${user.toMap()}');
      await firestore.collection('users').doc(uid).set(user.toMap());
      if (!mounted) {
        return;
      }

      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    } catch (e) {
      showAlertDialog(context: context, content: e.toString());
    }
  }
}
