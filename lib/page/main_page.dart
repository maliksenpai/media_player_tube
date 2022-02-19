import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:media_player_tube/page/music_page.dart';
import 'package:media_player_tube/page/video_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video & Music Player"),),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.ondemand_video_outlined, color: Colors.white,),
              label: Text("Videos"),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => VideoPage())
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.music_note, color: Colors.white,),
              label: Text("Musics"),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => MusicPage())
                );
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.green
              ),
            )
          ],
        ),
      ),
    );
  }
}
