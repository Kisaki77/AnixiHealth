
import 'package:health_anixi/State/loginState.dart';
import 'package:health_anixi/State/signupState.dart';
import 'package:health_anixi/pages/login.dart';
import 'package:health_anixi/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/ScreenImage.jpg'),
            ),
          ),
          // Logo
          Align(
            alignment: Alignment.center,
            child: Image(
              height: 500,
              width: 500,
              image: AssetImage('assets/images/logo.webp'),
            ),
          ),

          // Sign Up Link
          Positioned(
            top:800,
            bottom:40,
            left:30,
            right:30,
            child: Row(
              crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to the forgot password page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangeNotifierProvider.value(
                        value: signupState(),
                          child: MySignUp())
                      ),
                    );
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:20


                    ),
                  ),
                ),
                SizedBox(
                  width:200
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the guide page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangeNotifierProvider.value(
                          value:loginState(),
                          child: myLogin()
                      )
                      ),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:20

                    ),
                  ),
                ),
              ],
            ),
          ),
          // Login Link

        ],
      ),
    );
  }
}