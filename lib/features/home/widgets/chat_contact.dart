import 'package:flutter/material.dart';
import 'package:whatapp_clone/models/late_message_model.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/routers/router.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatContact extends StatelessWidget {
  final LastMessageModel lastMessage;
  const ChatContact({Key? key, required this.lastMessage}) : super(key: key);

  // ---- method to navigate to chat view---

  navigateToChatPage(context, UserModel user) {
    Navigator.of(context).pushNamed(Routes.chat, arguments: {'user': user});
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => navigateToChatPage(
        context,
        UserModel(
          name: lastMessage.name,
          uid: lastMessage.contactId,
          profilePic: lastMessage.profilePic,
          isOnline: true,
          lastSeen: 0,
          phoneNumber: '0',
          groupId: [],
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(lastMessage.name),
          Text(
            DateFormat.Hm().format(lastMessage.timeSent),
            style: TextStyle(
              fontSize: 13,
              color: context.theme.greyColor,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          lastMessage.lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: context.theme.greyColor),
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          lastMessage.profilePic,
        ),
        radius: 24,
      ),
    );
  }
}
