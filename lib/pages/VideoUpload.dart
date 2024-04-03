

import "dart:io";

import "package:flutter/material.dart";
import "package:health_anixi/Resources/save_video.dart";
import "package:health_anixi/State/VideoUploadState.dart";
import "package:health_anixi/pages/VideoLists.dart";
import "package:video_player/video_player.dart";

class VideoUpload extends StatefulWidget {
  const VideoUpload({super.key});

  @override
  State<VideoUpload> createState() => _VideoUploadState();
}

class _VideoUploadState extends State<VideoUpload> {
  String? _videoUrl;
  VideoPlayerController? videoController;
  String? downloadUrl;

  @override
  void dispose() {
    // TODO: implement dispose
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Video Upload"),
        actions:[
          IconButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return VideoLists();
                    }));
              },
              icon:Icon(Icons.history)
          )
        ]
      ),
      body:Center(
       child:_videoUrl !=null ? _videoPreviewWidget():const Text("No video Selected!")
      ),
      floatingActionButton:FloatingActionButton(
          onPressed:()async{
            _videoUrl = await VideoUploadState().pickVideo();
            _intializeVideoPlayer();
          },
          child:Icon(Icons.video_library)
      )
    );
  }

  void _intializeVideoPlayer(){
    videoController = VideoPlayerController.file(
        File(_videoUrl!))
        ..initialize().then((value){
          setState(() {
            videoController!.play();
          });
        });

  }

  Widget _videoPreviewWidget(){
    if(videoController !=null){
      return Column(
        children: [
          AspectRatio(
            aspectRatio: videoController!.value.aspectRatio,
            child:VideoPlayer(videoController!)
          ),
          ElevatedButton(onPressed: () async{
          downloadUrl = await StoreData().uploadVideo(_videoUrl!);
          await StoreData().saveVideoData(downloadUrl!);
          setState(() {
          _videoUrl = null;// to clear video
          });
          }, child: const Text("upload"))
        ],
      );
    }
    else{
      return const CircularProgressIndicator();
    }

  }

  _uploadVideo() async{

  }

}

