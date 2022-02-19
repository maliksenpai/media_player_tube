import 'package:flutter/cupertino.dart';
import 'package:media_player_tube/data/video_data.dart';
import 'package:media_player_tube/model/video.dart';

class VideoProvider extends ChangeNotifier{

  List<Video> videoList = [];
  bool isLoading = true;

  Future getVideos() async{
    await Future.delayed(Duration(seconds: 2),() {
    });
    for (var element in mediaJSON) {
      Video video = Video.fromJson(element);
      videoList.add(video);
    }
    isLoading = false;
    notifyListeners();
  }

  void setLoading(bool){
    isLoading = bool;
    notifyListeners();
  }

}