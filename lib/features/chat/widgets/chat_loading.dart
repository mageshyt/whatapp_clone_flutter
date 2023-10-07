import 'dart:math';

import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:shimmer/shimmer.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class ChatLoading extends StatelessWidget {
  ChatLoading({super.key});

  final List<int> list = [];

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 15; i++) {
      final random = Random().nextInt(14); // 0 - 14
      list.add(random);
    }
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Container(
          alignment:
              list[index].isEven ? Alignment.centerLeft : Alignment.centerRight,
          margin: EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: list[index].isEven ? 190 : 15,
            right: list[index].isEven ? 15 : 190,
          ),
          child: ClipPath(
            clipper: UpperNipMessageClipperTwo(
              list[index].isEven ? MessageType.send : MessageType.receive,
              nipWidth: 8,
              nipHeight: 10,
              bubbleRadius: 14,
            ),
            child: Shimmer.fromColors(
              baseColor: list[index].isEven
                  ? context.theme.greyColor!.withOpacity(0.3)
                  : context.theme.greyColor!.withOpacity(0.2),
              highlightColor: list[index].isEven
                  ? context.theme.greyColor!.withOpacity(0.4)
                  : context.theme.greyColor!.withOpacity(0.3),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.95,
                color: Colors.grey[300],
              ),
            ),
          ),
        );
      },
    );
  }
}
