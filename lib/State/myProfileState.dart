
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_anixi/Models/UserProfile.dart';

class myProfileState{

  myProfileState();
  Future<UserProfile> fetchProfileData() async{
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    DocumentReference docRef = await FirebaseFirestore.instance.collection("Users").doc(uid);
    DocumentSnapshot doc = await docRef.get();
    UserProfile user = UserProfile(
        birthday: doc.get("Birthday"),
        status: doc.get("Status"),
        province: doc.get("Province"),
        city: doc.get("City"),
        name: doc.get("Name"),
        email: doc.get("Email"),
        gender: doc.get("Male"),
        surname: doc.get("Surname"),
        userName: doc.get("Username")
    );
    return user;

  }






}