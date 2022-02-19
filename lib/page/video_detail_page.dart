import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:media_player_tube/model/video.dart';
import 'package:media_player_tube/view/video_player.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  Video video;

  VideoDetailPage({Key? key, required this.video}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController;
  bool loading = false;

  @override
  void initState() {
    initVideo();
    super.initState();
  }

  initVideo() async {
    setState(() {
      loading = false;
    });
    videoPlayerController = await VideoPlayerController.network(widget.video.sources);
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
        deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: true);
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title),
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: loading
                    ? CircularProgressIndicator()
                    : Expanded(
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Chewie(
                            controller: chewieController,
                          ),
                        ),
                      )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.video.subtitle,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(widget.video.description)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
