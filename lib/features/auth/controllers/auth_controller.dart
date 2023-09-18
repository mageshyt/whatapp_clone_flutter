import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:whatapp_clone/features/auth/repository/auth_repository.dart';
import 'package:whatapp_clone/models/user_model.dart';

final authControllerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepo, ref: ref);
});

final userAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.authRepository, required this.ref});
  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserInfo();
    return user;
  }

  void singInWithPhone(BuildContext context, String PhoneNumber) {
    authRepository.signInWithPhone(context, PhoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String otp) {
    authRepository.verifyOTP(
        context: context, verificationId: verificationId, OTP: otp);
  }

  void saveUserInfo(
      {required String username,
      required var profileImage,
      required BuildContext context,
      required bool mounted}) {
    authRepository.saveUserDataToFirebase(
        name: username,
        profileImage: profileImage,
        ref: ref,
        context: context,
        mounted: mounted);
  }
}
