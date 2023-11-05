import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/common.dart';

import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:audioplayers/audioplayers.dart';


class CustomAudioPlayer extends StatefulWidget {
  final String audioUrl;
  const CustomAudioPlayer({Key? key, required this.audioUrl}) : super(key: key);

  @override
  State<CustomAudioPlayer> createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  void togglePlayback() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(UrlSource(widget.audioUrl));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.receiverChatCardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) {
              // audioPlayer.seek(value);
            },
          ),
          CustomIconButton(
            onPressed: togglePlayback,
            icon:
                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
          ),
        ],
      ),
    );
  }
}
