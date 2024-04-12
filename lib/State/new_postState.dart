import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_anixi/Resources/save_media.dart';

class new_postState{
  new_postState();


  submitPost({required String thoughts,required String location,required String media,required String mediaType,required String extension, String? thumbnail}) async{
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    
    DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(uid);
    DocumentSnapshot user = await ref.get();


    FirebaseFirestore.instance.collection("Posts").add({
      "User":uid,
      "Thoughts":thoughts,
      "Location":location,
      "Media":media,
      "MediaType":mediaType,
      "Reported":false,
      "Date":DateTime.now(),
      "UserName":user.get("Name"),
      "UserPhoto": "Blank photo",
      "Hearts":0,
      "Comments":null,
      "Shares":0,
      "Thumbnail":thumbnail
    });
  }

  //Saves Media to Firebase Storage
  Future<String> saveMedia({
    required String media,
    required String mediaType,
    required String extension
  }) async{
    return await StoreData().uploadMedia(
        videoUrl: media,
        mediaType: mediaType,
        extension: extension);
  }







}