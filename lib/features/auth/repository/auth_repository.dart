import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:whatapp_clone/common/helper/show_alert_dialog.dart';
import 'package:whatapp_clone/common/helper/show_loading_dialoge.dart';
import 'package:whatapp_clone/common/repositories/common_firebase_storge_repo.dart';
import 'package:whatapp_clone/models/user_model.dart';

import 'package:whatapp_clone/routers/router.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      realtime: FirebaseDatabase.instance),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseDatabase realtime;

  AuthRepository({
    required this.auth,
    required this.firestore,
    required this.realtime,
  });

  // ---- function to get user status----
  Stream<UserModel?>  getUserPresenceStatus(String uid) {
    return auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;

      final userInfo = await firestore.collection('users').doc(user.uid).get();

      if (userInfo.data() == null) return null;

      return UserModel.fromMap(userInfo.data()!);
    });
    // get the last seen and isOnline status from realtime database
    // return realtime.ref().child(uid).onValue.map((event) {
    //   final data = event.snapshot.value as Map<dynamic, dynamic>;
    //   debugPrint('data $data');
    //   if (data.isEmpty) return null;
    //   return data;
    // });
  }

  // --- function to update the user presence
  void updateUserPresence() async {
    Map<String, dynamic> online = {
      'isOnline': true,
      'lastseen': DateTime.now().millisecondsSinceEpoch
    };
    Map<String, dynamic> offline = {
      'isOnline': false,
      'lastseen': DateTime.now().millisecondsSinceEpoch
    };

    debugPrint('user id ${auth.currentUser!.uid}');
    debugPrint(online.toString());
    final connectedRef = realtime.ref('.info/connected');

    final uid = auth.currentUser!.uid;

    connectedRef.onValue.listen((event) async {
      final isConnected = event.snapshot.value as bool;
      if (isConnected) {
        // ---- update the user online status  in realtime db----
        await realtime.ref().child(uid).update(online);

        // ---- update the user online status in firestore db----

        await firestore.collection('users').doc(uid).update(online);
      } else {
        await realtime.ref().child(uid).onDisconnect().update(offline);
        await firestore.collection('users').doc(uid).update(offline);
      }
    });
  }

//  ---- function to sign in with phone number ----
  void signInWithPhone(BuildContext context, String phone) async {
    try {
      showLoadingDialog(
        context: context,
        message: "Sending a verification code to $phone",
      );
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
      showLoadingDialog(
        context: context,
        message: 'Verifiying code ... ',
      );
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
    debugPrint('user info ${userInfo.data()}');
    if (userInfo.data() == null) return user;
    user = UserModel.fromMap(userInfo.data()!);
    return user;
  }

  // ---- function to save user to firebase ----
  void saveUserDataToFirebase(
      {required String name,
      required var profileImage,
      required ProviderRef ref,
      required BuildContext context,
      required bool mounted}) async {
    try {
      showLoadingDialog(
        context: context,
        message: "Saving user info ... ",
      );
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
          lastSeen: DateTime.now().millisecondsSinceEpoch,
          name: name,
          uid: uid,
          profilePic: profileImageUrl,
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
