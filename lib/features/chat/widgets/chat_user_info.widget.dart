import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/chat/widgets/IconWithText.dart';
import 'package:whatapp_clone/features/chat/widgets/lastSeenMessage.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class ChatUserInfoWidget extends StatelessWidget {
  final UserModel user;
  const ChatUserInfoWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          user.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 5),
        // ---- phpne number----
        Text(
          user.phoneNumber,
          style: TextStyle(
            color: context.theme.greyColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        // --- status----
        Text(
          'last seen ${lastSeenMessage(user.lastSeen)}',
          style: TextStyle(
              color: context.theme.greyColor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        // ---- media, docs, links, voice calls, video calls, groups, payments, settings----
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconWithText(
              icon: Icons.call,
              text: 'Call',
            ),
            IconWithText(
              icon: Icons.videocam,
              text: 'Video call',
            ),
            IconWithText(
              icon: Icons.search,
              text: 'search',
            ),
          ],
        ),
      ],
    );
  }
}
