
import 'package:health_anixi/State/signupState.dart';
import 'package:health_anixi/firebase_auth/firebase_auth_services.dart';
import 'package:health_anixi/pages/forgot.dart';
import 'package:health_anixi/pages/guide.dart';
import 'package:health_anixi/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_anixi/State/loginState.dart';

class myLogin extends StatefulWidget {
  const myLogin({Key? key}) : super(key: key);
  @override
  State<myLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<myLogin> {
  // final FirebaseAuthService _auth = FirebaseAuthService();
  //
  //
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  // @override
  // void dispose() {
  //
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final loginState_v = Provider.of<loginState>(context);


    Color myColor = const Color.fromARGB(255, 74, 95, 86);
    return Scaffold(
          body: Container(
              color: myColor,  // Set background color here
              width: double.infinity,
              height: double.infinity,
            child: Form(
              key:loginState.formKey,
              child: ListView(
                children: [
                  Container(
                      height:500,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/Anixihealth.png"),
                          fit: BoxFit.scaleDown,
                        ),
                      )),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 300,
                            height: 50,
                            child: TextFormField(
                              controller: loginState_v.email,
                              validator: (email){
                                return loginState_v.validateEmail(email!);
                              },
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,

                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              style: TextStyle(color: Colors.white),)
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Container(
                              width: 300,
                              height: 50,
                              child:  TextFormField(
                                controller: loginState_v.password,
                                validator:(password){
                                  return loginState_v.validatePassword(password!);
                                },
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,

                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),)
                          ),
                        ),
                        const SizedBox(height: 1,),
                        Padding(
                            padding: const EdgeInsets.only(left: 185,top: 10),
                            child: Row(

                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to the next page here
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  const forgotpsw()),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),


                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: ()async{
                            print("Here");
                            dynamic loggedIn = await loginState_v.loginInClicked(context);
                            print(loginState_v.error);
                            if(loggedIn !=null){
                              Navigator.pushNamed(context, "/home");
                            }
                            else{
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                        title:Center(
                                          child: Text(
                                              'Error',
                                            style:TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,

                                            )
                                          ),
                                        ),
                                        content: Text(
                                            loginState_v.error,
                                          style: TextStyle(
                                            color: myColor
                                          ),
                                        ),
                                        actions:<Widget>[
                                          TextButton(
                                              onPressed:(){
                                                loginState_v.email.clear();
                                                loginState_v.password.clear();
                                                loginState_v.resetError();
                                                Navigator.of(context).pop();//

                                              },
                                              child:Center(
                                                child: Text(
                                                    "Ok",
                                                  style:TextStyle(
                                                    color: myColor,
                                                    fontWeight: FontWeight.bold
                                                  )


                                                ),
                                              )
                                          )
                                        ]

                                    );
                                  }
                              );
                            }
                            },
                          child: Container(
                            height: 55,
                            width: 300,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 249, 253), // Background color
                              borderRadius: BorderRadius.circular(0), // Rounded corners
                            ),
                            child: Center(
                              child: Text(
                                'LogIn',
                                style: TextStyle(
                                  color:myColor, // Text color
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),




                      ]
                  ),
                  Padding(
                    padding: const EdgeInsets.all(55),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to the forgot password page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChangeNotifierProvider.value(
                                value:signupState(),
                                  child: MySignUp())
                              ),
                            );
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 18,
                            ),
                          ),
                        ),GestureDetector(
                          onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const GuidePage()),
                            );
                          },
                          child: const Text(
                            "See Guide",
                            style: TextStyle(
                              color: Colors.white,

                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        );

  }
  // void _signIn() async {
  //
  //   // Get user input values
  //
  //   String email = _emailController.text;
  //   String password = _passwordController.text;
  //
  //   User? user = await  _auth.signInWithEmailandPassword(email, password );
  //
  //   if(user!=null){
  //     if (kDebugMode) {
  //       print("User successfully SignIn!");
  //     }
  //     Navigator.pushNamed(context, "/home");
  //   }
  //   else{
  //     if (kDebugMode) {
  //       print("Failed");
  //     }
  //   }
  //
  //   // Store user data in Firestore
  // }
}