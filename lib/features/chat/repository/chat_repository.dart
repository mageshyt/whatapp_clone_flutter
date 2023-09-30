import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/common/enum/message_typing.dart';
import 'package:whatapp_clone/common/helper/show_alert_dialog.dart';
import 'package:whatapp_clone/models/late_message_model.dart';
import 'package:whatapp_clone/models/message_model.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:uuid/uuid.dart';
// !----- provider -----

final ChatRepositoryProvider = Provider((ref) => ChatRepository(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    ));

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.firestore, required this.auth});

  // ----- method to get last message  [used in chat's screen]------

  Stream<List<LastMessageModel>> getAllLastMessageList() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      final List<LastMessageModel> contact = [];

      debugPrint('current User >> ${auth.currentUser!.uid}');

      for (var document in event.docs) {
        // get the last message
        final lastMessage = LastMessageModel.fromMap(document.data());
        // get the user data
        final userData = await firestore
            .collection('users')
            .doc(lastMessage.contactId)
            .get();

        // convert the user data to user model
        final user = UserModel.fromMap(userData.data()!);

        contact.add(LastMessageModel(
          name: user.name,
          profilePic: user.profilePic,
          contactId: user.uid!,
          timeSent: lastMessage.timeSent,
          lastMessage: lastMessage.lastMessage,
        ));

        debugPrint('last message ${document.data()}');
      }

      return contact;
    });
  }

  // ------ method to send message ------

  void sendTextMessage(
      {required BuildContext context,
      required String receiverId,
      required String textMessage,
      required UserModel senderData}) async {
    try {
      // time send
      final sendedAt = DateTime.now();

      // get the receiver data

      final receiverDataMap =
          await firestore.collection('users').doc(receiverId).get();

      final receiverData = UserModel.fromMap(receiverDataMap.data()!);

      debugPrint('receiver data ${receiverData.name}');
      // generate message id
      final textMessageId = const Uuid().v1();

      saveToMessageCollection(
        receiverId: receiverId,
        textMessage: textMessage,
        sendedAt: sendedAt,
        textMessageId: textMessageId,
        receiverUsername: receiverData.name,
        messageType: MessageType.text,
      );

      // save last message

      saveLastMessage(
          senderUserData: senderData,
          receiverUserData: receiverData,
          textMessage: textMessage,
          receiverId: receiverId,
          sendedAt: sendedAt);

      print('Message saved');
    } catch (e) {
      showAlertDialog(context: context, content: e.toString());
    }
  }

  // ------ save message to firestore ------

  void saveToMessageCollection({
    required String receiverId,
    required String textMessage,
    required DateTime sendedAt,
    required String textMessageId,
    required String receiverUsername,
    required MessageType messageType,
  }) async {
    final Message = MessageModel(
        senderId: auth.currentUser!.uid,
        receiverId: receiverId,
        textMessage: textMessage,
        type: messageType,
        timeSent: sendedAt,
        messageId: textMessageId,
        isSeen: false);

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(textMessageId)
        .set(Message.toMap());
  }

  // ------ method to save last message ------

  void saveLastMessage({
    required UserModel senderUserData,
    required UserModel receiverUserData,
    required String textMessage,
    required String receiverId,
    required DateTime sendedAt,
  }) async {
    final receiverLastMessage = LastMessageModel(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uid!,
      timeSent: sendedAt,
      lastMessage: textMessage,
    );

// ------ save last message to receiver ------
    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(receiverLastMessage.toMap());

// ------ save last message to sender ------

    final senderLastMessage = LastMessageModel(
      name: receiverUserData.name,
      profilePic: receiverUserData.profilePic,
      contactId: receiverUserData.uid!,
      timeSent: sendedAt,
      lastMessage: textMessage,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .set(senderLastMessage.toMap());

    print('Last message saved');
  }
}
