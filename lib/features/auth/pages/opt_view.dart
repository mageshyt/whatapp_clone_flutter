import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
 

  final String verificationId;
  final String phoneNumber;

  const OTPScreen({super.key, required this.verificationId,required this.phoneNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
