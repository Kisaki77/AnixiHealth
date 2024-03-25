import 'package:cloud_firestore/cloud_firestore.dart';

class signup_threeState{

  signup_threeState();

  uploadUserData({
    required String uid,
    required String province,
    required String city,
    required String condition,
    required String status,
    required String username,
    required String birthday,
    required String gender
}) async{
    await FirebaseFirestore.instance.collection("Users").doc(uid).set(
      {
        "Province": province,
        "City": city,
        "Condition": condition,
        "Gender":gender,
        "Username":username,
        "Birthday":birthday,
        "Status":status
      },
      SetOptions(merge:true)
    );
  }



}