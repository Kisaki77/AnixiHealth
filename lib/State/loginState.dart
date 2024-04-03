
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_anixi/Models/UserAnixi.dart';



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

  // Returns user object which contains firebaseID
  UserAnixi? _userFromFireBaseUser(User? user){
    return user == null ? null: UserAnixi(uid: user!.uid);
  }

  Future <UserAnixi?> loginInClicked(BuildContext context)async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email.text, password: password.text);
      if(!userCredential.user!.emailVerified){
        await userCredential.user!.sendEmailVerification();
        error = "Click the verification link on your email to continue!";
      }

      else {
        return _userFromFireBaseUser(userCredential.user!);
      }
    }
    on FirebaseAuthException catch(e){
      return _handleFirebaseAuthError(e);


    }
    catch(e){
      print("Error: $e");
      error+=e.toString();
      return null;
    }

  }

  UserAnixi? _handleFirebaseAuthError(FirebaseAuthException e){
    switch (e.code) {
      case "admin-restricted-operation":
        error += "This operation is restricted to administrators only.\n";
        break;
      case "app-not-authorized":
        error += "This app, identified by the domain where it's hosted, is not authorized to use Firebase Authentication with the provided API key. Review your key configuration in the Google API console.\n";
        break;
      case "app-not-installed":
        error += "The requested mobile application corresponding to the identifier (Android package name or iOS bundle ID) provided is not installed on this device.\n";
        break;
      case "captcha-check-failed":
        error += "The reCAPTCHA response token provided is either invalid, expired, already used or the domain associated with it does not match the list of whitelisted domains.\n";
        break;
      case "code-expired":
        error += "The SMS code has expired. Please re-send the verification code to try again.\n";
        break;
      case "cordova-not-ready":
        error += "Cordova framework is not ready.\n";
        break;
      case "cors-unsupported":
        error += "This browser is not supported.\n";
        break;
      case "credential-already-in-use":
        error += "This credential is already associated with a different user account.\n";
        break;
      case "custom-token-mismatch":
        error += "The custom token corresponds to a different audience.\n";
        break;
      case "requires-recent-login":
        error += "This operation is sensitive and requires recent authentication. Log in again before retrying this request.\n";
        break;
      case "dynamic-link-not-activated":
        error += "Please activate Dynamic Links in the Firebase Console and agree to the terms and conditions.\n";
        break;
      case "email-change-needs-verification":
        error += "Multi-factor users must always have a verified email.\n";
        break;
      case "email-already-in-use":
        error += "The email address is already in use by another account.\n";
        break;
      case "expired-action-code":
        error += "The action code has expired.\n";
        break;
      case "cancelled-popup-request":
        error += "This operation has been cancelled due to another conflicting popup being opened.\n";
        break;
      case "internal-error":
        error += "An internal error has occurred.\n";
        break;
      case "invalid-app-credential":
        error += "The phone verification request contains an invalid application verifier. The reCAPTCHA token response is either invalid or expired.\n";
        break;
      case "invalid-app-id":
        error += "The mobile app identifier is not registered for the current project.\n";
        break;
      case "invalid-user-token":
        error += "This user's credential isn't valid for this project. This can happen if the user's token has been tampered with, or if the user isn't for the project associated with this API key.\n";
        break;
      case "invalid-auth-event":
        error += "An internal error has occurred.\n";
        break;
      case "invalid-verification-code":
        error += "The SMS verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure to use the verification code provided by the user.\n";
        break;
      case "invalid-continue-uri":
        error += "The continue URL provided in the request is invalid.\n";
        break;
      case "invalid-cordova-configuration":
        error += "The following Cordova plugins must be installed to enable OAuth sign-in: cordova-plugin-buildinfo, cordova-universal-links-plugin, cordova-plugin-browsertab, cordova-plugin-inappbrowser, and cordova-plugin-customurlscheme.\n";
        break;
      case "invalid-custom-token":
        error += "The custom token format is incorrect. Please check the documentation.\n";
        break;
      case "invalid-dynamic-link-domain":
        error += "The provided dynamic link domain is not configured or authorized for the current project.\n";
        break;
      case "invalid-email":
        error += "The email address is badly formatted.\n";
        break;
      case "invalid-api-key":
        error += "Your API key is invalid, please check you have copied it correctly.\n";
        break;
      case "invalid-cert-hash":
        error += "The SHA-1 certificate hash provided is invalid.\n";
        break;
      case "invalid-credential":
        error += "The supplied auth credential is malformed or has expired.\n";
        break;
      case "invalid-message-payload":
        error += "The email template corresponding to this action contains invalid characters in its message. Please fix by going to the Auth email templates section in the Firebase Console.\n";
        break;
      case "invalid-multi-factor-session":
        error += "The request does not contain a valid proof of first factor successful sign-in.\n";
        break;
      case "invalid-oauth-provider":
        error += "EmailAuthProvider is not supported for this operation. This operation only supports OAuth providers.\n";
        break;
      case "invalid-oauth-client-id":
        error += "The OAuth client ID provided is either invalid or does not match the specified API key.\n";
        break;
      case "unauthorized-domain":
        error += "This domain is not authorized for OAuth operations for your Firebase project. Edit the list of authorized domains from the Firebase console.\n";
        break;
      case "invalid-action-code":
        error += "The action code is invalid. This can happen if the code is malformed, expired, or has already been used.\n";
        break;
      case "wrong-password":
        error += "The password is invalid or the user does not have a password.\n";
        break;
      case "invalid-persistence-type":
        error += "The specified persistence type is invalid. It can only be local, session, or none.\n";
        break;
      case "invalid-phone-number":
        error += "The format of the phone number provided is incorrect. Please enter the phone number in a format that can be parsed into E.164 format. E.164 phone numbers are written in the format [+][country code][subscriber number including area code].\n";
        break;
      case "invalid-provider-id":
        error += "The specified provider ID is invalid.\n";
        break;
      case "invalid-recipient-email":
        error += "The email corresponding to this action failed to send as the provided recipient email address is invalid.\n";
        break;
      case "invalid-sender":
        error += "The email template corresponding to this action contains an invalid sender email or name. Please fix by going to the Auth email templates section in the Firebase Console.\n";
        break;
      case "invalid-verification-id":
        error += "The verification ID used to create the phone auth credential is invalid.\n";
        break;
      case "invalid-tenant-id":
        error += "The Auth instance's tenant ID is invalid.\n";
        break;
      case "multi-factor-info-not-found":
        error += "The user does not have a second factor matching the identifier provided.\n";
        break;
      case "multi-factor-auth-required":
        error += "Proof of ownership of a second factor is required to complete sign-in.\n";
        break;
      case "missing-android-pkg-name":
        error += "An Android Package Name must be provided if the Android App is required to be installed.\n";
        break;
      case "auth-domain-config-required":
        error += "Be sure to include authDomain when calling firebase.initializeApp(), by following the instructions in the Firebase console.\n";
        break;
      case "missing-app-credential":
        error += "The phone verification request is missing an application verifier assertion. A reCAPTCHA response token needs to be provided.\n";
        break;
      case "missing-verification-code":
        error += "The phone auth credential was created with an empty SMS verification code.\n";
        break;
      case "missing-continue-uri":
        error += "A continue URL must be provided in the request.\n";
        break;
      case "missing-iframe-start":
        error += "An internal error has occurred.\n";
        break;
      case "missing-ios-bundle-id":
        error += "An iOS Bundle ID must be provided if an App Store ID is provided.\n";
        break;
      case "missing-multi-factor-info":
        error += "No second factor identifier is provided.\n";
        break;
      case "missing-multi-factor-session":
        error += "The request is missing proof of first factor successful sign-in.\n";
        break;
      case "missing-or-invalid-nonce":
        error += "The request does not contain a valid nonce. This can occur if the SHA-256 hash of the provided raw nonce does not match the hashed nonce in the ID token payload.\n";
        break;
      case "missing-phone-number":
        error += "To send verification codes, provide a phone number for the recipient.\n";
        break;
      case "missing-verification-id":
        error += "The phone auth credential was created with an empty verification ID.\n";
        break;
      case "app-deleted":
        error += "This instance of FirebaseApp has been deleted.\n";
        break;
      case "account-exists-with-different-credential":
        error += "An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.\n";
        break;
      case "network-request-failed":
        error += "A network error (such as timeout, interrupted connection, or unreachable host) has occurred.\n";
        break;
      case "no-auth-event":
        error += "An internal error has occurred.\n";
        break;
      case "no-such-provider":
        error += "User was not linked to an account with the given provider.\n";
        break;
      case "null-user":
        error += "A null user object was provided as the argument for an operation which requires a non-null user object.\n";
        break;
      case "operation-not-allowed":
        error += "The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.\n";
        break;
      case "operation-not-supported-in-this-environment":
        error += 'This operation is not supported in the environment this application is running on. "location.protocol" must be http, https, or chrome-extension, and web storage must be enabled.\n';
        break;
      case "popup-blocked":
        error += "Unable to establish a connection with the popup. It may have been blocked by the browser.\n";
        break;
      case "popup-closed-by-user":
        error += "The popup has been closed by the user before finalizing the operation.\n";
        break;
      case "provider-already-linked":
        error += "User can only be linked to one identity for the given provider.\n";
        break;
      case "quota-exceeded":
        error += "The project's quota for this operation has been exceeded.\n";
        break;
      case "redirect-cancelled-by-user":
        error += "The redirect operation has been cancelled by the user before finalizing.\n";
        break;
      case "redirect-operation-pending":
        error += "A redirect sign-in operation is already pending.\n";
        break;
      case "rejected-credential":
        error += "The request contains malformed or mismatching credentials.\n";
        break;
      case "second-factor-already-in-use":
        error += "The second factor is already enrolled on this account.\n";
        break;
      case "maximum-second-factor-count-exceeded":
        error += "The maximum allowed number of second factors on a user has been exceeded.\n";
        break;
      case "tenant-id-mismatch":
        error += "The provided tenant ID does not match the Auth instance's tenant ID\n";
        break;
      case "timeout":
        error += "The operation has timed out.\n";
        break;
      case "user-token-expired":
        error += "The user's credential is no longer valid. The user must sign in again.\n";
        break;
      case "too-many-requests":
        error += "We have blocked all requests from this device due to unusual activity. Try again later.\n";
        break;
      case "unauthorized-continue-uri":
        error += "The domain of the continue URL is not whitelisted.  Please whitelist the domain in the Firebase console.\n";
        break;
      case "unsupported-first-factor":
        error += "Enrolling a second factor or signing in with a multi-factor account requires sign-in with a supported first factor.\n";
        break;
      case "unsupported-persistence-type":
        error += "The current environment does not support the specified persistence type.\n";
        break;
      case "unsupported-tenant-operation":
        error += "This operation is not supported in a multi-tenant context.\n";
        break;
      case "unverified-email":
        error += "The operation requires a verified email.\n";
        break;
      case "user-cancelled":
        error += "The user did not grant your application the permissions it requested.\n";
        break;
      case "user-not-found":
        error += "There is no user record corresponding to this identifier. The user may have been deleted.\n";
        break;
      case "user-disabled":
        error += "The user account has been disabled by an administrator.\n";
        break;
      case "user-mismatch":
        error += "The supplied credentials do not correspond to the previously signed-in user.\n";
        break;
      case "user-signed-out":
        error += "\n";
        break;
      case "weak-password":
        error += "The password must be 6 characters long or more.\n";
        break;
      case "web-storage-unsupported":
        error += "This browser is not supported or 3rd party cookies and data may be disabled.\n";
        break;
      default:
        error += "An error occurred: $e\n";
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