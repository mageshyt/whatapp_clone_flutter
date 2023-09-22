import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/routers/router.dart';

class ChatView extends StatelessWidget {
  final UserModel user;
  const ChatView({Key? key, required this.user}) : super(key: key);

  // ---- method to navigate to contact view---
  navigateToContactPage(context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.contact, (route) => true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- name----
            Text(
              user.name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 3),
            // --- status----

            Text(
                user.isOnline
                    ? 'Online'
                    : DateTime.fromMicrosecondsSinceEpoch(user.lastSeen)
                        .toString(),
                style: TextStyle(fontSize: 12))
          ],
        ),
        leading: InkWell(
          onTap: () => navigateToContactPage(context),
          borderRadius: BorderRadius.circular(16),
          child: Row(
            children: [
              const Icon(Icons.arrow_back),
              CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
                radius: 16,
              ),
            ],
          ),
        ),
        actions: [
          CustomIconButton(
            icon: Icons.videocam,
            onPressed: () {},
            iconsColor: Colors.white,
          ),
          CustomIconButton(
            icon: Icons.call,
            onPressed: () {},
            iconsColor: Colors.white,
          ),
          CustomIconButton(
            icon: Icons.more_vert,
            onPressed: () {},
            iconsColor: Colors.white,
          ),
        ],
      ),
      body: const Center(
        child: Text('Chat Home View'),
      ),
    );
  }
}
