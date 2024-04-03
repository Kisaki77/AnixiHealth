

import "dart:io";

import "package:image_picker/image_picker.dart";
import "package:video_player/video_player.dart";
class VideoUploadState{
  String? videoUrl;
  VideoPlayerController? videoController;


  VideoUploadState();

   pickVideo() async{
    final picker = ImagePicker();
    XFile? videoFile;
    try{
       videoFile = await picker.pickVideo(source:ImageSource.gallery);
       return videoFile!.path;
    }

    catch(e){
      print("Error picking video : $e");

    }

  }



}