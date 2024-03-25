//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_anixi/Models/UserAnixi.dart';

class signupState with ChangeNotifier {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  String error = "";

  bool isEmailVerified =false;
  String emailConfirmation = "";
  final FirebaseAuth _auth= FirebaseAuth.instance;
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController passwordOriginal = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController emailValue = TextEditingController();


  //GETTERS
  GlobalKey<FormState> get formKey => _formKey;

  //Auth get auth => _auth;

  signupState() {

  }

  bool isEmailValid(String email) {
    // Regular expression pattern for validating email addresses
    // This pattern checks for basic email format, but it's not exhaustive.
    // Depending on your requirements, you might need to adjust it.
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  // Ensures that user types in correct email
  String? validateEmail(String email) {
    if (!isEmailValid(email)) {
      //user didn't enter email

      notifyListeners();
      return "Enter valid email!";
    }
    //user entered email correctly
    notifyListeners();
    return null;
  }

  String? validateName(String name) {
    if (name.isEmpty) {
      //user didn't enter email

      notifyListeners();
      return "Enter valid Name!";
    }
    //user entered email correctly
    notifyListeners();
    return null;
  }

  String? validateSurname(String surname) {
    if (surname.isEmpty) {
      //user didn't enter email

      notifyListeners();
      return "Enter valid Surname!";
    }
    //user entered email correctly
    notifyListeners();
    return null;
  }

  // ensures user types correct password
  String? validatePassword(String password) {
    if (password.length < 6) {
      //user didn't enter valid password

      notifyListeners();
      return "Enter password 6 characters long!";
    }
    notifyListeners();
    //user entered valid password
    return null;
  }

  // ensures user types correct password
  String? confirmPassword(String password) {
    if (password != passwordOriginal.text) {
      //user didn't enter valid password

      notifyListeners();
      return "Passwords do not match!";
    }
    notifyListeners();
    //user entered valid password
    return null;
  }

  // once register button is clicked

  signupClicked() async {
    if (_formKey.currentState!.validate()) {
      // if the form is valid
      loading = true;
      dynamic result = await registerWithEmailAndPassword(
          emailValue.text.trim(), passwordOriginal.text.trim()); //used dynamic because could either get user or null
      if (result == null) {
        loading = false;
        //error = "please supply a valid email";
      }
      return result;
    }
    notifyListeners();
  }



  // Returns user object which contains firebaseID
  UserAnixi? _userFromFireBaseUser(User? user){
    return user == null ? null: UserAnixi(uid: user!.uid);
  }

  // registers new user
  Future<UserAnixi?> registerWithEmailAndPassword(String email,String password) async{
    try {
      print("Email is: ${email}");
      print("password is: ${password}");
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("The result is: ${result}");
      //grab user from that result
      User? fb_user = result.user;

      if (fb_user != null) {
        await fb_user.sendEmailVerification().then((value) {});

        await FirebaseFirestore.instance.collection("Users")
            .doc(fb_user.uid)
            .set({
          "Name": name.text.trim(),
          "Surname": surname.text.trim(),
          "Email": emailValue.text.trim()
        });
      }
      print("------------ User in userState is $fb_user");

      return _userFromFireBaseUser(fb_user!);
    }
    on FirebaseAuthException catch(e){
      return _handleFirebaseAuthError(e);

    }
   catch (e) {
  // Handle generic errors
  print("Error: $e");
  error+=e.toString();
  return null;
  }

  }
    UserAnixi? _handleFirebaseAuthError(FirebaseAuthException e){
      switch (e.code) {
        case "email-already-in-use":
          error += "Email already registered, sign in.\n";
          break;
        case "invalid-email":
          error += "Your email address appears to be malformed.\n";
          break;
        case "wrong-password":
          error += "Your password is wrong.\n";
          break;
        case "user-not-found":
          error += "User with this email doesn't exist.\n";
          break;
        case "user-disabled":
          error += "User with this email has been disabled.\n";
          break;
        case "too-many-requests":
          error += "Too many requests. Try again later.\n";
          break;
        case "operation-not-allowed":
          error += "Signing in with Email and Password is not enabled.\n";
          break;
        case "network-request-failed":
          error += "Please check your internet connection.\n";
          break;
        default:

          error += "An undefined Error happened.\n";
      }
      notifyListeners();
      return null;
    }

  // Reset the error variable
  void resetError() {
    error = "";
    notifyListeners();
  }

}
