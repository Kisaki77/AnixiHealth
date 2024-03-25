
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class loginState with ChangeNotifier{

  bool loading = false;
  String error = "";
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  static final formKey = GlobalKey<FormState>(); // allows validation of user input
  loginState(){

  }


  // Ensures that user types in correct email
  String? validateEmail(String email) {
    if (email.isEmpty) {
      //user didn't enter email

      notifyListeners();
      return "Enter email";
    }
    //user entered email correctly
    notifyListeners();
    return null;
  }

  String? validatePassword(String password) {
    if (password.length < 5) {
      notifyListeners();
      return "Password must be at least 5 characters long!";
    }
    notifyListeners();
    return null;
  }

  loginInClicked(BuildContext context)async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email.text, password: password.text);
      if(!userCredential.user!.emailVerified){
        await userCredential.user!.sendEmailVerification();
        error = "Click the verification link on your email to continue!";
      }

      else {
        return userCredential.user;
      }
    }
    on FirebaseAuthException catch(e){


      error = signInErrors(e.code);
      return null;
    }

  }

  signInErrors(Object error){
    switch (error) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination!";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email!";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled!";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid!";
        break;
      default:
        return "Login failed. Please try again.";
        break;
    }
  }
}