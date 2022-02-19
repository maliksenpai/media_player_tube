import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  String url;

  CustomVideoPlayer({Key? key, required this.url}) : super(key: key);

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  bool isPlaying = false;
  bool isReady = false;
  Duration videoDuration = Duration.zero;
  Duration currentDuration = Duration.zero;
  Duration loadedDuration = Duration.zero;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.url)
      ..initialize().then((value) {
        setState(() {
          videoPlayerController.play();
          isPlaying = true;
          isReady = true;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    isReady = false;
    super.dispose();
  }

  String twoDigits(int n) => n.toString().padLeft(2, "0");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isReady ? ValueListenableBuilder(
          valueListenable: videoPlayerController,
          builder: (context, VideoPlayerValue value, child) {
            videoDuration = value.duration;
            currentDuration = value.position;
            loadedDuration = value.buffered.last.end;
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AspectRatio(aspectRatio: 16 / 9, child: VideoPlayer(videoPlayerController)),
                Container(
                  color: Colors.black26,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          value.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (value.isPlaying) {
                            await videoPlayerController.pause();
                          } else {
                            await videoPlayerController.play();
                          }
                        },
                      ),
                      Flexible(
                        child: Stack(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(thumbShape: SliderComponentShape.noThumb),
                              child: Slider(
                                value: loadedDuration.inSeconds / videoDuration.inSeconds,
                                onChanged: (value) {
                                  videoPlayerController.seekTo(Duration(seconds: (value * videoDuration.inSeconds).ceil()));
                                },
                                activeColor: Colors.grey[50],
                              ),
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(thumbShape: SliderComponentShape.noThumb),
                              child: Slider(
                                value: currentDuration.inSeconds / videoDuration.inSeconds,
                                onChanged: (value) {
                                  videoPlayerController.seekTo(Duration(seconds: (value * videoDuration.inSeconds).ceil()));
                                },
                                activeColor: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          "${twoDigits(currentDuration.inMinutes)}:${twoDigits(currentDuration.inSeconds.remainder(60))} "
                              "/ ${twoDigits(videoDuration.inMinutes)}:${twoDigits(videoDuration.inSeconds.remainder(60))}",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }) : CircularProgressIndicator(),
    );
  }
}
