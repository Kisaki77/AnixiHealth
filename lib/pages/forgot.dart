import 'package:health_anixi/State/forgotState.dart';
import 'package:health_anixi/State/loginState.dart';
import 'package:health_anixi/pages/login.dart';
import 'package:health_anixi/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class forgotpsw extends StatelessWidget {
  const forgotpsw({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    Color myColor = const Color.fromARGB(255, 74, 95, 86);
    return MaterialApp(
        home: Scaffold(
          body: Container(
            color: myColor,  // Set background color here
            width: double.infinity,
            height: double.infinity,
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
                    const SizedBox(height: 100,),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                          width: 250,
                          child: TextField(
                            controller:email,

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
                    ),



                    const SizedBox(height: 50,),
                    GestureDetector(
                      onTap:()async{
                        await forgotState().resetPassword(email: email.text);
                        if(forgotState().error.isNotEmpty){
                          AlertDialog(
                              title: Text(
                                  'Error',
                                style:TextStyle(
                                  color:Colors.red,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              content: Text(
                                  forgotState().error,
                                style: TextStyle(
                                  color:myColor
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {

                                      Navigator.of(context)
                                          .pop(); //
                                    },
                                    child: Text(
                                        "Ok",
                                      style:TextStyle(
                                        color:myColor,
                                        fontWeight: FontWeight.bold
                                      )
                                    )
                                )
                              ]

                          );
                        }
                        else{
                           AlertDialog(
                              title: Text(
                                  'Success',
                                style:TextStyle(
                                  color:Colors.green,
                                  fontWeight: FontWeight.bold
                                )),
                              content: Text(
                                  "Password reset link successfully sent to email!",
                              style:TextStyle(
                                color:myColor
                              )),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {

                                      Navigator.of(context)
                                          .pop(); //
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return ChangeNotifierProvider.value(
                                              value:loginState(),
                                              child: myLogin()
                                          );
                                        }),
                                      );
                                    },
                                    child: Text(
                                        "Ok",
                                      style: TextStyle(
                                        color: myColor,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                )
                              ]

                          );


                        }
                      },
                      child: Container(
                        height: 50,
                        width: 250,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: const Center(child: Text('Reset Password',
                          style: TextStyle(
                            color: Color.fromARGB(255, 35, 87, 79),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),),),
                      ),
                    ),


                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 280, bottom: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to the forgot password page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MySignUp()),
                            );
                          },
                          child: const Text(
                            "Sign up",
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
                  alignment: Alignment.bottomRight,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {

                              // Navigate to the guide page
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return ChangeNotifierProvider.value(
                                    value:loginState(),
                                      child: myLogin()
                                  );
                                }),
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
                      )
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}