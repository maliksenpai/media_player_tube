import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:media_player_tube/provider/music_provider.dart';
import 'package:media_player_tube/view/music_player.dart';
import 'package:provider/src/provider.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(context.read<MusicProvider>().audioList.isEmpty){
      context.read<MusicProvider>().getMusics();
    }

    return Scaffold(
      appBar: AppBar(title: Text("Music List"),),
      body: Center(
        child: context.watch<MusicProvider>().isLoading ?
        CircularProgressIndicator() :
        ListView.builder(
          itemCount: context.watch<MusicProvider>().audioList.length,
          itemBuilder: (context, index){
            var music = context.watch<MusicProvider>().audioList[index];
            return MusicPlayer(music: music);
          },
        ),
      ),
    );
  }
}
