import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class CustomAudioPlayer extends StatefulWidget {
  final String audioUrl;
  const CustomAudioPlayer({Key? key, required this.audioUrl}) : super(key: key);

  @override
  State<CustomAudioPlayer> createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  bool isPlaying = false;
  final assetsAudioPlayer = AssetsAudioPlayer();

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  void togglePlayback() async {
    if (isPlaying) {
      await assetsAudioPlayer.pause();
    } else {
      await assetsAudioPlayer.open(Audio.network(widget.audioUrl));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void initState() {
    assetsAudioPlayer.currentPosition.listen((event) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Slider(
          min: 0,
          max: duration.inSeconds.toDouble(),
          value: position.inSeconds.toDouble(),
          onChanged: (value) {
            // Seek to the specified position
            // assetsAudioPlayer.seek(Duration(seconds: value.toInt()));

            // setState(() {
            //   position = Duration(seconds: value.toInt());
            // });
          },
        ),
        CustomIconButton(
          onPressed: togglePlayback,
          icon: isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
        ),
      ],
    );
  }
}
