
import 'package:health_anixi/State/loginState.dart';
import 'package:health_anixi/firebase_auth/firebase_auth_services.dart';
import 'package:health_anixi/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_anixi/pages/signup_two.dart';
import 'package:provider/provider.dart';
import 'package:health_anixi/State/signupState.dart';

class MySignUp extends StatefulWidget {
  const MySignUp({Key? key}) : super(key: key);


  @override
  State<MySignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {
  // final FirebaseAuthService _auth = FirebaseAuthService();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController  _fnameController = TextEditingController();
  // final TextEditingController  _lnameController = TextEditingController();


  // @override
  // void dispose() {
  //
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   _fnameController.dispose();
  //   _lnameController.dispose();
  //
  //   super.dispose();
  // }

  // Get auth service

  @override
  Widget build(BuildContext context) {
    final signupState_v = Provider.of<signupState>(context);
    Color myColor = const Color.fromARGB(255, 74, 95, 86);

    return Scaffold(
        body: Form(
          key: signupState_v.formKey,
          child: Container(
            color: myColor,  // Set background color here
            width: double.infinity,
            height: double.infinity,
            child: ListView(
                children: [
                  Container(
                      height:400,
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
                              controller: signupState_v.name,
                              validator: (name) {
                                return signupState_v.validateName(name!);
                              },
                              decoration: const InputDecoration(
                                hintText: 'First Name',
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
                              style: const TextStyle(
                                  color: Colors.white),)
                        ),

                        const SizedBox(height: 10,),


                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                controller: signupState_v.surname,
                                validator: (surname) {
                                  return signupState_v.validateSurname(
                                      surname!);
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Last Name',
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
                                style: const TextStyle(
                                    color: Colors.white),)
                          ),
                        ),

                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                controller: signupState_v.emailValue,
                                validator: (email) {
                                  return signupState_v.validateEmail(
                                      email!);
                                },
                                decoration: const InputDecoration(
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
                                style: const TextStyle(
                                    color: Colors.white),)
                          ),
                        ),


                        const SizedBox(height: 10,),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                controller: signupState_v.passwordOriginal,
                                validator: (password) {
                                  return signupState_v.validatePassword(
                                      password!);
                                },
                                obscureText: true,
                                decoration: const InputDecoration(
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
                                style: const TextStyle(
                                    color: Colors.white),)
                          ),
                        ),
                        const SizedBox(height: 10,),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                controller: signupState_v.passwordConfirm,
                                validator: (password) {
                                  return signupState_v.confirmPassword(
                                      password!);
                                },
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Confirm Password',

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
                                style: const TextStyle(
                                    color: Colors.white),)
                          ),
                        ),
                      ]
                  ),

                  const SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 300, bottom: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              dynamic user = await signupState_v
                                  .signupClicked();
                              print("_______________________ user is : $user");

                              if (user != null) {
                                print("User added: ${user.uid}");
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return SignTwoPage(uid: user!.uid);
                                    }

                                ));
                              }
                              else if (signupState_v.error.isNotEmpty) {
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: Center(
                                              child: Text(
                                                  'Error',
                                                style: TextStyle(
                                                  color:Colors.red,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              )
                                          ),
                                          content: Text(
                                              signupState_v.error,
                                            style: TextStyle(
                                              color:myColor
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  signupState_v.emailValue
                                                      .clear();
                                                  signupState_v.passwordOriginal
                                                      .clear();
                                                  signupState_v.passwordConfirm
                                                      .clear();
                                                  signupState_v.name.clear();
                                                  signupState_v.surname.clear();
                                                  signupState_v.resetError();
                                                  Navigator.of(context)
                                                      .pop(); //
                                                },
                                                child: Center(
                                                    child: Text(
                                                        "Okay",
                                                      style: TextStyle(
                                                        color: myColor,
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    )
                                                )
                                            )
                                          ]

                                      );
                                    }
                                );
                              }
                            },

                            child: const Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 30, bottom: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigate to the guide page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context){
                                         return ChangeNotifierProvider.value(
                                                value:loginState(),
                                                child: myLogin()
                                                );
                                                }
                                      ),
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        )),
                  )
                ]
            ),
          ),
        )
    );
  }
}


  // void signUp() async {
  //
  //
  //   // Get user input values
  //
  //   String email = _emailController.text;
  //   String password = _passwordController.text;
  //
  //   User? user = await  _auth.signupWithEmailAndPassword(email, password );
  //
  //   if (user!= null){
  //     print ("User Successfully signup");
  //     Navigator.pushNamed(context, "/email");
  //   } else{
  //     print("Some error happed");
  //   }





    // Store user data in Firestore
  //}

//}
