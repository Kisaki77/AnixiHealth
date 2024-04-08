

import "dart:io";

import "package:flutter/material.dart";
import "package:health_anixi/Resources/save_media.dart";
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
  Color myColor = const Color.fromARGB(255, 74, 95, 86);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: myColor,
        title:Text(""
            "Video Upload",
          style: TextStyle(
            color:Colors.white
          ),
            ),
        centerTitle: true,
        actions:[
          IconButton(
            iconSize: 50,
              color: Colors.black,
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return VideoLists();
                    }));
              },
              icon:Icon(
                  Icons.history,
                color: Colors.black,
              )
          )
        ]
      ),

      body:ListView(
        children: [
          Center(
           child:_videoUrl !=null ? _videoPreviewWidget(): Padding(
             padding: const EdgeInsets.all(50),
             child: Card(
                 child: Padding(
                   padding: const EdgeInsets.all(20),
                   child: Text("No video Selected!"),
                 )
             ),
           )
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: ()async{
                _videoUrl = await VideoUploadState().pickVideo();
                _intializeVideoPlayer();
              },
              child: Container(
                height: 55,
                width: 300,
                decoration: BoxDecoration(
                  color: myColor, // Background color
                  borderRadius: BorderRadius.circular(0), // Rounded corners
                ),
                child: Center(
                  child: Text(
                    'Add Video',
                    style: TextStyle(
                      color:Colors.white, // Text color
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton:FloatingActionButton(
      //     onPressed:()async{
      //       _videoUrl = await VideoUploadState().pickVideo();
      //       _intializeVideoPlayer();
      //     },
      //     child:Icon(Icons.video_library)
      // )
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
          ),SizedBox(
            height: 10,
          ),Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: ()async{
                downloadUrl = await StoreData().uploadMedia(videoUrl: _videoUrl!, mediaType: "Video", extension: "mp4");
                await StoreData().saveVideoData(downloadUrl!);
                setState(() {
                  _videoUrl = null;// to clear video
                });
              },

              child: Container(
                height: 55,
                width: 300,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 243, 249, 253), // Background color
                  borderRadius: BorderRadius.circular(0), // Rounded corners
                ),
                child: Center(
                  child: Text(
                    'Upload Video',
                    style: TextStyle(
                      color:myColor, // Text color
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
          // ElevatedButton(
          //     onPressed: () async{
          // downloadUrl = await StoreData().uploadVideo(_videoUrl!);
          // await StoreData().saveVideoData(downloadUrl!);
          // setState(() {
          // _videoUrl = null;// to clear video
          // });
          // }, child: const Text("upload"))
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

