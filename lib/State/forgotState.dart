import 'package:firebase_auth/firebase_auth.dart';

class forgotState{
 String error = "";
  forgotState();

  resetPassword({required String email})async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    }
    catch(e){
      error = e.toString();
    }
    }
  }


