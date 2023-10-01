import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/features/chat/controller/chat_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:whatapp_clone/features/home/widgets/chat_contact.dart';

import 'package:whatapp_clone/models/late_message_model.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/routers/router.dart';
import 'package:intl/intl.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class ChatHomeView extends ConsumerWidget {
  const ChatHomeView({Key? key}) : super(key: key);

  // ---- method to navigate to contact view---
  navigateToContactPage(context) {
    Navigator.pushNamed(
      context,
      Routes.contact,
    );
  }

  // ---- method to navigate to chat view---

  navigateToChatPage(context, UserModel user) {
    Navigator.of(context).pushNamed(Routes.chat, arguments: {'user': user});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: StreamBuilder<List<LastMessageModel>>(
            stream: ref.watch(chatControllerProvider).getAllLastMessageList(),
            builder: (_, snapshot) {
              // ! ------------------ watch state------------------
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ThemeColors.greenDark,
                  ),
                );
              }

              // ! ------------- list of last message -------------

              final List<LastMessageModel> lastMessageList = snapshot.data!;

              return ListView.builder(
                itemCount: lastMessageList.length,
                itemBuilder: (context, index) {
                  debugPrint('>> ${lastMessageList[0].toString()}');
                  return ChatContact(lastMessage: lastMessageList[index]);
                },
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => navigateToContactPage(context),
          child: const Icon(Icons.chat),
        ));
  }
}
