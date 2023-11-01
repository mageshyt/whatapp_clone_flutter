import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whatapp_clone/common/common.dart';

// import 'package:cached_video_player/cached_video_player.dart';
class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;

  bool isPlaying = false;
  @override
  void initState() {
    debugPrint('video url: ${widget.videoUrl}');
    super.initState();

    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((_) {
            videoPlayerController.setVolume(1);
          });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: videoPlayerController.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer(videoPlayerController),
          Positioned(
            bottom: 0,
            right: 0,
            child: isPlaying
                ? CustomIconButton(
                    icon: Icons.pause,
                    iconsColor: Colors.white,
                    onPressed: () {
                      videoPlayerController.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    })
                : CustomIconButton(
                    icon: Icons.play_arrow,
                    iconsColor: Colors.white,
                    onPressed: () {
                      videoPlayerController.play();
                      setState(() {
                        isPlaying = true;
                      });
                    }),
          )
        ],
      ),
    );
  }
}
