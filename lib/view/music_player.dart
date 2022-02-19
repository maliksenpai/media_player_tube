import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:media_player_tube/model/audio.dart';
import 'package:media_player_tube/provider/music_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class MusicPlayer extends StatefulWidget {
  Music music;

  MusicPlayer({Key? key, required this.music}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  late MusicProvider musicProvider;
  bool isPlaying = false;
  bool isInit = false;

  @override
  void initState() {
    musicProvider = context.read<MusicProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isPlaying = musicProvider.currentId == widget.music.id;
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.music_video,
                size: 50,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.music.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  if (isPlaying && musicProvider.isPlaying) {
                    musicProvider.pauseMusic(widget.music);
                  } else {
                    musicProvider.setMusic(widget.music);
                  }
                },
                icon: isPlaying && musicProvider.isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
              )
            ],
          ),
          isPlaying
              ? SliderTheme(
                  data: SliderTheme.of(context).copyWith(thumbShape: SliderComponentShape.noThumb, thumbColor: Colors.transparent ),
                  child: Slider(
                    value: musicProvider.currentDuration.inSeconds / musicProvider.totalDuration.inSeconds,
                    onChanged: (value) {
                      musicProvider.seekMusic(Duration(seconds: (value * musicProvider.totalDuration.inSeconds).ceil()));
                    },
                    activeColor: Colors.primaries.first,
                  ),
                )
              : Container(),
        ],
      ),
    ));
  }
}
