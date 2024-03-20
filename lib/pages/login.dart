import 'package:anixii_health/firebase_auth/firebase_auth_services.dart';
import 'package:anixii_health/pages/forgot.dart';
import 'package:anixii_health/pages/guide.dart';
import 'package:anixii_health/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class myLogin extends StatefulWidget {  
  const myLogin({Key? key}) : super(key: key);
  @override
  State<myLogin> createState() => _MyLoginState();
}

  class _MyLoginState extends State<myLogin> {
    final FirebaseAuthService _auth = FirebaseAuthService();
  
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

   @override
  void dispose() {
    
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Color myColor = const Color.fromARGB(255, 74, 95, 86);
  return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
                 color: myColor,  // Set background color here
              width: double.infinity, 
              height: double.infinity, 
            ),
            const Align(
              alignment: Alignment.topCenter,
               child :FractionalTranslation(
                translation: Offset(0.0, -0.1),
              child: Image(
                height: 500,
                width: 500,
                image: AssetImage('assets/images/logo.webp'),

            ),
               )
          ),
          
               Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 200,),
                   Padding(
                    padding: EdgeInsets.all(10.0),
                      child: Container(
                         width: 250,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: '                  Email',
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
                     Padding(
                    padding: EdgeInsets.all(10.0),
                      child: Container(
                         width: 250,
                    child:  TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: '                Password',
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
                   onTap: _signIn,
                      child: Container(
    height: 50,
    width: 250,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 243, 249, 253), // Background color
      borderRadius: BorderRadius.circular(10), // Rounded corners
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
              ),
                 Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 300, bottom: 20),
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
                      )
                    ),
            )
            ],
          ),
        )
  );
  }
  void _signIn() async {
  
    // Get user input values
    
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await  _auth.signInWithEmailandPassword(email, password );

    if(user!=null){
      if (kDebugMode) {
        print("User successfully SignIn!");
      }
      Navigator.pushNamed(context, "/home");
    }
    else{
       if (kDebugMode) {
         print("Failed");
       }
    }

    // Store user data in Firestore
  }
}