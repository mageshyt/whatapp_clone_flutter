import 'dart:math';

import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:shimmer/shimmer.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class ChatLoading extends StatelessWidget {
  ChatLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        final random = Random().nextInt(14);
        return Container(
          alignment:
              random.isEven ? Alignment.centerLeft : Alignment.centerRight,
          margin: EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: random.isEven ? 190 : 15,
            right: random.isEven ? 15 : 190,
          ),
          child: ClipPath(
            clipper: UpperNipMessageClipperTwo(
              random.isEven ? MessageType.send : MessageType.receive,
              nipWidth: 8,
              nipHeight: 10,
              bubbleRadius: 14,
            ),
            child: Shimmer.fromColors(
              baseColor: random.isEven
                  ? context.theme.greyColor!.withOpacity(0.3)
                  : context.theme.greyColor!.withOpacity(0.2),
              highlightColor: random.isEven
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
