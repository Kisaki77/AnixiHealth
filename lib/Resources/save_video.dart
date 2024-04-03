
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

class StoreData{
  Future<String> uploadVideo(String videoUrl) async{
    Reference ref = _storage.ref().child('videos/${DateTime.now()}.mp4');//Specifies Firebase storage path for uploaded video
    await ref.putFile(File(videoUrl));
    String downloadUrl = await ref.getDownloadURL(); // getDownload.. returns uploaded videos URl from Firestore
    return downloadUrl;
  }

  Future<void> saveVideoData(String videoDownloadUrl) async{
    await FirebaseFirestore.instance.collection("Videos").add(
      {
       'Url':videoDownloadUrl,
       "Time" :FieldValue.serverTimestamp(),
        "Name":"User video"
      }
    );
  }
}