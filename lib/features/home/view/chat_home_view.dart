import 'package:flutter/material.dart';
import 'package:whatapp_clone/routers/router.dart';

class ChatHomeView extends StatelessWidget {
  const ChatHomeView({Key? key}) : super(key: key);

  // ---- method to navigate to contact view---
  navigateToContactPage(context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.contact, (route) => true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text('Chat Home View'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => navigateToContactPage(context),
          child: const Icon(Icons.chat),
        ));
  }
}
