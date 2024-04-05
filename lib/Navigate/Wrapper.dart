import "package:flutter/material.dart";
import "package:health_anixi/pages/PaymentScreen.dart";
import "package:health_anixi/pages/VideoUpload.dart";
import "package:health_anixi/pages/newfeed.dart";
import "package:health_anixi/pages/screen.dart";
import "package:provider/provider.dart";
import "package:firebase_auth/firebase_auth.dart";
class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {


    User? user = Provider.of<User?>(context); // acessing user data from

    // if it returns a user that means that that user is signed in (registered)
    try {
      user!.reload().then((value){

      });
      if (user==null){
        // user not signed in
        return MyScreen();
      }
      else if(user!.emailVerified == false){
        return MyScreen();
      }

      else{
          return VideoUpload();
        //return NewsFeedPage();
      }
    }catch (e) {
      return MyScreen();
    }


  }
}