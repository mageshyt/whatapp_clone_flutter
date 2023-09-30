import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/constants/constants.dart';

import 'package:whatapp_clone/features/chat/widgets/chat_appbar.widget.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/routers/router.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:whatapp_clone/features/chat/widgets/chat_field.widget.dart';

class ChatView extends ConsumerWidget {
  final UserModel user;
  const ChatView({Key? key, required this.user}) : super(key: key);

  // ---- method to navigate to contact view---
  navigateToContactPage(context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: ChatAppBar(user: user),
      body: Stack(
        children: [
          Image(
            fit: BoxFit.cover,
            height: double.maxFinite,
            width: double.maxFinite,
            color: context.theme.photoIconBgColor,
            image: const AssetImage(AssetsConstant.doodle_bg),
          ),

          // ---- chat view----

          Column(
            children: [
              // ---- chat list view----
              Expanded(
                child: Container(),
              ),
              const SizedBox(height: 5),
              ChatFieldWidget(receiverId: user.uid!)
            ],
          )
        ],
      ),
    );
  }
}
