import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:media_player_tube/page/video_detail_page.dart';
import 'package:media_player_tube/provider/video_provider.dart';
import 'package:provider/provider.dart';

class VideoPage extends StatelessWidget {

  VideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(context.read<VideoProvider>().videoList.isEmpty){
      context.read<VideoProvider>().getVideos();
    }

    return Scaffold(
      appBar: AppBar(title: Text("Videos Page"),),
      body: Center(
        child: context.watch<VideoProvider>().isLoading ?
        CircularProgressIndicator() :
        ListView.builder(
          itemCount: context.watch<VideoProvider>().videoList.length,
          itemBuilder: (context, index){
            var video = context.watch<VideoProvider>().videoList[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoDetailPage(video: video))
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.video_label, size: 50,),
                      SizedBox(width: 5,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(video.title, style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(video.subtitle)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ),
            );
          },
        )
        ,
      ),
    );
  }
}

