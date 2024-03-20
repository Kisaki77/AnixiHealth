import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{
  
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signupWithEmailAndPassword( email, password) async{
      try {
      UserCredential credential =await  _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;

  }

     Future<User?> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential credential =await  _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;

  }


   // Method to send the email verification link
Future<void> sendEmailVerification() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  await currentUser?.sendEmailVerification();
}


  }
