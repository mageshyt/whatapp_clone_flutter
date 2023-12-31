import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/common/enum/message_typing.dart';
import 'package:whatapp_clone/common/helper/show_alert_dialog.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/features/auth/pages/image_picker_view.dart';
import 'package:whatapp_clone/features/chat/controller/chat_controller.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:flutter/scheduler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class ChatFieldWidget extends ConsumerStatefulWidget {
  const ChatFieldWidget(
      {Key? key, required this.receiverId, required this.scrollController})
      : super(key: key);
  final String receiverId;
  final ScrollController scrollController;

  @override
  _ChatFieldWidgetState createState() => _ChatFieldWidgetState();
}

class _ChatFieldWidgetState extends ConsumerState<ChatFieldWidget> {
  File? imageCamera;
  bool isMessageIconEnabled = false;
  double cardHeight = 0;
  FlutterSoundRecorder? _soundRecorder;
  //! state for recorder
  bool isRecorderInit = false;
  bool isRecording = false;

  late TextEditingController messageController;

  void scrollDown() {
    if (widget.scrollController.hasClients) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } else {
      debugPrint('>> scroll controller has no client');
    }
  }
  // ! ----------------- message controller -----------------

  void sendMessage() async {
    if (isMessageIconEnabled && messageController.text.isNotEmpty) {
      ref.read(chatControllerProvider).sendTextMessage(
          context: context,
          receiverId: widget.receiverId,
          textMessage: messageController.text);
      messageController.clear();
      setState(() => isMessageIconEnabled = false);
    } else {
      // ! ----------------- send audio message -----------------
      var tempDir = await getTemporaryDirectory();
      var filePath = '${tempDir.path}/flutter_sound_example.aac';

      if (isRecording && isRecorderInit) {
        await _soundRecorder!.stopRecorder();
        sendFileMessage(File(filePath), MessageType.audio);
      } else {

        await _soundRecorder!.startRecorder(
          toFile: filePath,
          codec: Codec.aacMP4,
        );
      }

      setState(() {
        isRecording = !isRecording;
      });
    }
    await Future.delayed(const Duration(milliseconds: 500));

    scrollDown();
  }

  void setCardHeight() {
    setState(() {
      cardHeight == 0 ? cardHeight = 220 : cardHeight = 0;
    });
  }

// ! Widget Iconwith Text

  iconWithText({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    required Color background,
  }) {
    return Column(
      children: [
        CustomIconButton(
          onPressed: onPressed,
          icon: icon,
          backgroundColor: background,
          minWidth: 50,
          iconsColor: Colors.white,
          border: Border.all(
            color: context.theme.greyColor!.withOpacity(.2),
            width: 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
            color: context.theme.greyColor,
          ),
        ),
      ],
    );
  }

  // ! ----------------- send image from gallery-----------------
  void sendImageFromGallery() async {
    final image = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ImagePickerView(),
        ));

    // find the type of the file image or video or audio
    MessageType messageType;

    if (image != null) {
      sendFileMessage(image, MessageType.image);
      setCardHeight();
    }
  }

  void sendFileMessage(var file, MessageType messageType) async {
    ref.read(chatControllerProvider).sendFileMessage(
          context,
          file,
          widget.receiverId,
          messageType,
        );

    // scroll to bottom
    await Future.delayed(const Duration(milliseconds: 2500));
    scrollDown();
  }

  void pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      sendFileMessage(imageTemporary, MessageType.image);
    } catch (e) {
      showAlertDialog(context: context, content: e.toString(), title: 'Error');
    }
  }

  void sendVideoFromGallery() async {
    try {
      final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

      if (video == null) return;

      final videoTemporary = File(video.path);

      sendFileMessage(videoTemporary, MessageType.video);

      setCardHeight();
    } catch (e) {
      showAlertDialog(context: context, content: e.toString(), title: 'Error');
    }
  }

  void openAudio() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      showAlertDialog(
          context: context,
          content: 'Please grant permission to record audio',
          title: 'Permission required');
      return;
    }
  }

  @override
  void initState() {
    messageController = TextEditingController();
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          height: cardHeight,
          width: double.maxFinite,
          // padding: const EdgeInsets.only(top: 10, bottom: 10),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: context.theme.inputFillColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    iconWithText(
                      onPressed: () {},
                      icon: Icons.book,
                      text: 'File',
                      background: const Color(0xFF7F66FE),
                    ),
                    iconWithText(
                      onPressed: sendVideoFromGallery,
                      icon: Icons.videocam,
                      text: 'Video',
                      background: const Color(0xFFFE2E74),
                    ),
                    iconWithText(
                      onPressed: sendImageFromGallery,
                      icon: Icons.photo,
                      text: 'Gallery',
                      background: const Color(0xFFC861F9),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    iconWithText(
                      onPressed: () {},
                      icon: Icons.headphones,
                      text: 'Audio',
                      background: const Color(0xFFF96533),
                    ),
                    iconWithText(
                      onPressed: () {},
                      icon: Icons.location_on,
                      text: 'Location',
                      background: const Color(0xFF1FA855),
                    ),
                    iconWithText(
                      onPressed: () {},
                      icon: Icons.person,
                      text: 'Contact',
                      background: const Color(0xFF009DE1),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),

        // ! ----------------- chat field -----------------
        Padding(
          padding:
              const EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
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
                          // ! ----------------- attachment button -----------------
                          AnimatedSwitcher(
                            duration: const Duration(
                                milliseconds:
                                    300), // Adjust the duration as needed
                            child: cardHeight == 0
                                ? RotatedBox(
                                    quarterTurns: 1,
                                    child: CustomIconButton(
                                      key: const ValueKey<int>(
                                          0), // Ensure unique keys for each child
                                      icon: Icons.attach_file,
                                      onPressed: setCardHeight,
                                      iconsColor: Theme.of(context)
                                          .listTileTheme
                                          .iconColor,
                                    ),
                                  )
                                : CustomIconButton(
                                    key: const ValueKey<int>(
                                        1), // Ensure unique keys for each child
                                    icon: Icons.close,
                                    onPressed: setCardHeight,
                                    iconsColor: Theme.of(context)
                                        .listTileTheme
                                        .iconColor,
                                  ),
                          ),
                          CustomIconButton(
                            icon: Icons.camera_alt_outlined,
                            onPressed: pickImageFromCamera,
                            iconsColor:
                                Theme.of(context).listTileTheme.iconColor,
                          ),
                        ],
                      )),
                ),
              ),

              const SizedBox(width: 5),
              //----------------- send button-----------------

              CustomIconButton(
                icon: isMessageIconEnabled
                    ? Icons.send
                    : isRecording
                        ? Icons.close
                        : Icons.mic_none,
                onPressed: sendMessage,
                backgroundColor: ThemeColors.greenDark,
                iconsColor: Colors.white,
              ),

              const SizedBox(width: 5)
            ],
          ),
        ),
      ],
    );
  }
}
