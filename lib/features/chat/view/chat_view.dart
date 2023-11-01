import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/constants/constants.dart';
import 'package:whatapp_clone/features/chat/controller/chat_controller.dart';

import 'package:whatapp_clone/features/chat/widgets/chat_appbar.widget.dart';
import 'package:whatapp_clone/features/chat/widgets/chat_loading.dart';
import 'package:whatapp_clone/features/chat/widgets/message_tile.dart';
import 'package:whatapp_clone/features/chat/widgets/show_date_card.dart';
import 'package:whatapp_clone/features/chat/widgets/yellow_card.dart';
import 'package:whatapp_clone/models/message_model.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/routers/router.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:whatapp_clone/features/chat/widgets/chat_field.widget.dart';

import '../../../common/enum/message_typing.dart';

final pageStorageBucket = PageStorageBucket();

class ChatView extends ConsumerWidget {
  final UserModel user;
  ChatView({Key? key, required this.user}) : super(key: key);

  // ---- method to navigate to contact view---
  navigateToContactPage(context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
  }

  // ---- method to show nip in chat view----
  bool shouldShowNip(int index, List<MessageModel>? messages) {
    if (index == 0) {
      return true;
    }

    final previousMessageSenderId = messages![index - 1].senderId;
    final currentMessageSenderId = messages[index].senderId;

    if (index == messages.length - 1) {
      return previousMessageSenderId != currentMessageSenderId;
    }

    final nextMessageSenderId = messages[index + 1].senderId;

    return (previousMessageSenderId != currentMessageSenderId) ||
        (nextMessageSenderId != currentMessageSenderId);
  }

// ----scroll controller----

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: ChatAppBar(user: user),
      body: Stack(
        children: [
          //
          Image(
            fit: BoxFit.cover,
            height: double.maxFinite,
            width: double.maxFinite,
            color: context.theme.chatPageDoodleColor,
            image: const AssetImage(AssetsConstant.doodle_bg),
          ),

          // ---- chat view----

          const SizedBox(height: 5),

          // ---- chat list view----
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: StreamBuilder(
              stream: ref
                  .watch(chatControllerProvider)
                  .getAllMessageList(contactId: user.uid!),
              builder: (context, snapshot) {
                //  ! if loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // loading animation

                  return ChatLoading();
                }

                return PageStorage(
                  bucket: pageStorageBucket,
                  child: ListView.builder(
                    key: const PageStorageKey('chat-list-view'),
                    controller: scrollController,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final message = snapshot.data?[index];
                      final isMe = FirebaseAuth.instance.currentUser!.uid ==
                          message?.senderId;
                      // Case for showing the nip
                      // [1] if it's the first message
                      // [2] if it's the last message
                      // [3] if the previous message is from another sender

                      final haveNip = shouldShowNip(index, snapshot.data);

                      return Column(
                        children: [
                          // ------- chat header message -------
                          if (index == 0) YellowCard(),
                          // ------- chat date message -------
                          if (index == 0 ||
                              message?.timeSent.day !=
                                  snapshot.data?[index - 1].timeSent.day)
                            ShowDateCard(
                                date: message?.timeSent ?? DateTime.now()),
                          // ------- chat message -------
                          MessageTile(
                            message: message as MessageModel,
                            isSender: isMe,
                            haveNip: haveNip,
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: const Alignment(0, 1),
            child: ChatFieldWidget(
              receiverId: user.uid!,
              scrollController: scrollController,
            ),
          )
        ],
      ),
    );
  }
}
