
import 'package:anixii_health/pages/login.dart';
import 'package:anixii_health/pages/signup.dart';
import 'package:flutter/material.dart';

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

           // Sign Up Link
           Align(
            alignment: Alignment.bottomRight,
          
              child: Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 20),
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
                          
                         
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Login Link
            Align(
              alignment: Alignment.bottomLeft,
              
              child: Padding(
                padding: const EdgeInsets.only(left: 300, bottom: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to the guide page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => myLogin()),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                         
                        ),
                      ),
                    ),
                  ],
                      )
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
        ],
      ),
    );
  }
}