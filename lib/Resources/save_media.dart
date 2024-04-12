
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;

class StoreData{
  Future<String> uploadMedia({required String videoUrl,required String mediaType,required String extension}) async{

    Reference ref = _storage.ref().child('${mediaType}s/${DateTime.now()}.$extension');//Specifies Firebase storage path for uploaded video
    await ref.putFile(File(videoUrl));
    String downloadUrl = await ref.getDownloadURL(); // getDownload.. returns uploaded videos URl from Firestore
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection("Media").add(
        {
          'Url':downloadUrl,
          "Time" :FieldValue.serverTimestamp(),
          "MediaType":mediaType,
          "User":uid

        }
    );
    return downloadUrl;


  }

  Future<void> saveVideoData(String videoDownloadUrl) async{

  }
}