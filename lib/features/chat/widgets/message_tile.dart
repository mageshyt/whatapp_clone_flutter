import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/models/message_model.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:intl/intl.dart';

class MessageTile extends ConsumerWidget {
  final MessageModel? message;
  final bool isMe;
  final bool haveNip;
  const MessageTile(
      {super.key,
      required this.message,
      required this.isMe,
      required this.haveNip});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // ------- message alignment ------

      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: isMe
            ? 80
            : haveNip
                ? 15
                : 10,
        right: isMe
            ? haveNip
                ? 15
                : 10
            : 80,
      ),

      child: ClipPath(
        clipper: haveNip
            ? UpperNipMessageClipperTwo(
                isMe ? MessageType.send : MessageType.receive,
                nipWidth: 8,
                nipHeight: 10,
                bubbleRadius: haveNip ? 14 : 0,
              )
            : null,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.95,
          ),

          padding: EdgeInsets.only(
            top: 7,
            bottom: 7,
            left: isMe ? 10 : 15,
            right: isMe ? 15 : 10,
          ),

          // ------- message decoration ------
          decoration: BoxDecoration(
            color: isMe
                ? context.theme.senderChatCardBg
                : context.theme.receiverChatCardBg,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: haveNip ? null : BorderRadius.circular(12),
          ),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                "${message!.textMessage}        ",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                DateFormat.Hm().format(message!.timeSent),
                style: TextStyle(
                  fontSize: 11,
                  color: context.theme.greyColor,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
