import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/features/chat/controller/chat_controller.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class ChatFieldWidget extends ConsumerStatefulWidget {
  const ChatFieldWidget({Key? key, required this.receiverId}) : super(key: key);
  final String receiverId;

  @override
  _ChatFieldWidgetState createState() => _ChatFieldWidgetState();
}

class _ChatFieldWidgetState extends ConsumerState<ChatFieldWidget> {
  bool isMessageIconEnabled = false;

  // ! ----------------- message controller -----------------

  void sendMessage() async {
    if (isMessageIconEnabled && messageController.text.isNotEmpty) {
      ref.read(chatControllerProvider).sendTextMessage(
          context: context,
          receiverId: widget.receiverId,
          textMessage: messageController.text);
      messageController.clear();
      setState(() => isMessageIconEnabled = false);
    }
  }

  late TextEditingController messageController;

  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: messageController,
              maxLines: 4,
              minLines: 1,
              autofocus: true,
              autocorrect: true,
              onChanged: (value) {
                value.isNotEmpty
                    ? setState(() => isMessageIconEnabled = true)
                    : setState(() => isMessageIconEnabled = false);
              },
              decoration: InputDecoration(
                  hintText: 'Message',
                  hintStyle: TextStyle(color: context.theme.greyColor),
                  filled: true,
                  fillColor: context.theme.inputFillColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  prefixIcon: Container(
                    color: Colors.transparent,
                    child: CustomIconButton(
                      icon: Icons.emoji_emotions_outlined,
                      onPressed: () {},
                      iconsColor: Theme.of(context).listTileTheme.iconColor,
                    ),
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RotatedBox(
                        quarterTurns: 45,
                        child: CustomIconButton(
                          icon: Icons.attach_file,
                          onPressed: () {},
                          iconsColor: Theme.of(context).listTileTheme.iconColor,
                        ),
                      ),
                      CustomIconButton(
                        icon: Icons.camera_alt_outlined,
                        onPressed: () {},
                        iconsColor: Theme.of(context).listTileTheme.iconColor,
                      ),
                    ],
                  )),
            ),
          ),

          const SizedBox(width: 5),
          //----------------- send button-----------------

          CustomIconButton(
            icon: isMessageIconEnabled ? Icons.send : Icons.mic_none,
            onPressed: sendMessage,
            backgroundColor: ThemeColors.greenDark,
            iconsColor: Colors.white,
          ),

          const SizedBox(width: 5)
        ],
      ),
    );
  }
}
