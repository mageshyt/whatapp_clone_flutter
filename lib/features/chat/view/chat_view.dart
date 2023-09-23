import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatapp_clone/features/chat/widgets/chat_appbar.widget.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/routers/router.dart';

class ChatView extends ConsumerWidget {
  final UserModel user;
  const ChatView({Key? key, required this.user}) : super(key: key);

  // ---- method to navigate to contact view---
  navigateToContactPage(context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: ChatAppBar(user: user),
      body: const Center(
        child: Text('Chat Home View'),
      ),
    );
  }
}
