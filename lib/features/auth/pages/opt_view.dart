import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  static Route<dynamic> route(String verficationId) {
    return MaterialPageRoute(
        builder: (context) => OTPScreen(
              verficationId: verficationId,
            ));
  }

  final String verficationId;

  const OTPScreen({super.key, required this.verficationId});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
