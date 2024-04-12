import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class newfeedState{

  newfeedState();
  
  heartPost({required String docId}) async{
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("Posts").doc(docId).collection("Hearts").doc(uid).set(
        {
          "Date":DateTime.now()
        });
    CollectionReference heartRef = await FirebaseFirestore.instance.collection("Posts").doc(docId).collection("Hearts");
    QuerySnapshot heartSnapshot = await heartRef.get();
    int numberOfHearts = heartSnapshot.size;
    FirebaseFirestore.instance.collection("Posts").doc(docId).set(
        {
          "Hearts":numberOfHearts
        },SetOptions(merge:true));

  }









}