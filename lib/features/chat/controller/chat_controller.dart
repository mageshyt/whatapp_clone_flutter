import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:whatapp_clone/features/auth/controllers/auth_controller.dart';
import 'package:whatapp_clone/features/chat/repository/chat_repository.dart';
import 'package:whatapp_clone/models/late_message_model.dart';

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
