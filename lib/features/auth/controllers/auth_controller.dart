import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:whatapp_clone/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepo);
});

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  void singInWithPhone(BuildContext context, String PhoneNumber) {
    authRepository.signInWithPhone(context, PhoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String otp) {
    authRepository.verifyOTP(
        context: context, verificationId: verificationId, OTP: otp);
  }
}
