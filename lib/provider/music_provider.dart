import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/widgets.dart';
import 'package:media_player_tube/data/music_data.dart';
import 'package:media_player_tube/model/audio.dart';

class MusicProvider extends ChangeNotifier{

  List<Music> audioList = [];
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  String currentId = "";
  bool isLoading = true;
  bool isPlaying = false;
  Duration currentDuration = Duration.zero;
  Duration totalDuration = Duration.zero;

  Future getMusics() async{
    await Future.delayed(Duration(seconds: 2),() {
    });
    audioList = audioData;
    isLoading = false;
    assetsAudioPlayer.playlistFinished.listen((event) {
      if(event){
        currentId = "";
        notifyListeners();
      }
    });
    assetsAudioPlayer.current.listen((event) {
      totalDuration = event!.audio.duration;
      notifyListeners();
    });
    assetsAudioPlayer.currentPosition.listen((event) {
      currentDuration = event;
      notifyListeners();
    });
    assetsAudioPlayer.isPlaying.listen((event) {
      isPlaying = event;
      notifyListeners();
    });
    notifyListeners();
  }

  void setLoading(bool){
    isLoading = bool;
    notifyListeners();
  }

  Future setMusic(Music music) async{
    if(currentId == music.id){
      assetsAudioPlayer.play();
    }else{
      await assetsAudioPlayer.open(
          Audio.network(music.url, metas: Metas(title: music.name)),
          showNotification: true,
          autoStart: true
      );
      currentId = music.id;
    }
    notifyListeners();
  }

  Future pauseMusic(Music music) async {
    if(currentId == music.id){
      assetsAudioPlayer.pause();
    }
    notifyListeners();
  }

  Future seekMusic(Duration duration) async{
    assetsAudioPlayer.seek(duration);
  }
}