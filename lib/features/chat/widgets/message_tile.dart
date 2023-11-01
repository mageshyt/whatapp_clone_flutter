import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatapp_clone/features/chat/widgets/video_player_item.dart';
import 'package:whatapp_clone/models/message_model.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:whatapp_clone/common/enum/message_typing.dart' as my_type;

class MessageTile extends ConsumerWidget {
  final MessageModel message;
  final bool isSender;
  final bool haveNip;
  const MessageTile(
      {super.key,
      required this.message,
      required this.isSender,
      required this.haveNip});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: isSender
            ? 80
            : haveNip
                ? 10
                : 15,
        right: isSender
            ? haveNip
                ? 10
                : 15
            : 80,
      ),
      child: ClipPath(
        clipper: haveNip
            ? UpperNipMessageClipperTwo(
                isSender ? MessageType.send : MessageType.receive,
                nipWidth: 0, // if you don't want nip set 0 else 8
                nipHeight: 0, // if you don't want nip set 0 else 10
                bubbleRadius: 10, // set bubble radius
              )
            : null,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isSender
                    ? context.theme.senderChatCardBg
                    : context.theme.receiverChatCardBg,
                // borderRadius: haveNip ? null : BorderRadius.circular(12),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black38),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: message.type == my_type.MessageType.image
                    ? Padding(
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image(
                            image:
                                CachedNetworkImageProvider(message.textMessage),
                          ),
                        ),
                      )
                    : message.type == my_type.MessageType.video
                        ? Padding(
                            padding: const EdgeInsets.all(6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: VideoPlayerItem(
                                videoUrl: message.textMessage,
                              ), // Replace with your VideoPlayer widget
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                              left: isSender ? 10 : 15,
                              right: isSender ? 15 : 10,
                            ),
                            child: Text(
                              "${message.textMessage}         ",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
              ),
            ),
            Positioned(
              bottom: message.type == my_type.MessageType.text ? 8 : 4,
              right: message.type == my_type.MessageType.text
                  ? isSender
                      ? 15
                      : 10
                  : 4,
              child: message.type == my_type.MessageType.text
                  ? Text(
                      DateFormat.Hm().format(message.timeSent),
                      style: TextStyle(
                        fontSize: 11,
                        color: context.theme.greyColor,
                      ),
                    )
                  : Container(
                      // width: 90,
                      padding: const EdgeInsets.only(
                          left: 90, right: 10, bottom: 10, top: 14),
                      // decoration: BoxDecoration(
                      //   gradient: LinearGradient(
                      //     begin: const Alignment(0, -1),
                      //     end: const Alignment(1, 1),
                      //     colors: [
                      //       context.theme.greyColor!.withOpacity(0),
                      //       context.theme.greyColor!.withOpacity(.5),
                      //     ],
                      //   ),
                      //   borderRadius: BorderRadius.all(Radius.circular(50)),
                      // ),

                      child: Text(
                        DateFormat.Hm().format(message.timeSent),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
