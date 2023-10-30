import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:whatapp_clone/common/enum/message_typing.dart';
import 'package:whatapp_clone/features/auth/controllers/auth_controller.dart';
import 'package:whatapp_clone/features/chat/repository/chat_repository.dart';
import 'package:whatapp_clone/models/late_message_model.dart';
import 'package:whatapp_clone/models/message_model.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepo = ref.watch(ChatRepositoryProvider);
  return ChatController(chatRepo: chatRepo, ref: ref);
});

class ChatController {
  final ChatRepository chatRepo;

  final ProviderRef ref;

  ChatController({required this.chatRepo, required this.ref});

// ! ----------------- get users messaged contact -----------------
  Stream<List<LastMessageModel>> getAllLastMessageList() {
    return chatRepo.getAllLastMessageList();
  }

// ! ----------------- get all message of contact -----------------

  Stream<List<MessageModel>> getAllMessageList({required String contactId}) {
    return chatRepo.getAllMessageList(contactId: contactId);
  }

// ! ----------------- send file -----------------
  void sendFileMessage(
    BuildContext context,
    var file,
    String receiverId,
    MessageType messageType,
  ) {
    ref.read(userAuthProvider).whenData((senderData) {
      return chatRepo.sendFileMessage(
        file: file,
        context: context,
        receiverId: receiverId,
        senderData: senderData!,
        ref: ref,
        messageType: messageType,
      );
    });
  }

  void sendTextMessage({
    required BuildContext context,
    required String receiverId,
    required String textMessage,
  }) {
    ref.read(userAuthProvider).whenData((user) {
      chatRepo.sendTextMessage(
        context: context,
        receiverId: receiverId,
        textMessage: textMessage,
        senderData: user!,
      );
    });
  }
}
