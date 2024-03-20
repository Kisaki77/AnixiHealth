import 'package:anixii_health/pages/login.dart';
import 'package:anixii_health/pages/signup.dart';
import 'package:flutter/material.dart';

class forgotpsw extends StatelessWidget {
  const forgotpsw({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              color:const Color.fromARGB(255, 74, 95, 86), // Set background color here
              width: double.infinity, 
              height: double.infinity, 
            ),
            Align(
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
                    const SizedBox(height: 100,),
                    Padding(
                    padding: EdgeInsets.all(10.0),
                      child: Container(
                         width: 250,
                    child: TextField(
                      
                      decoration: InputDecoration(
                        hintText: '                Username/Email',
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
                    Container(
                      height: 50,
                      width: 250,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: const Center(child: Text('Send OTP',
                          style: TextStyle(
                              color: Color.fromARGB(255, 35, 87, 79),
                            fontWeight: FontWeight.bold,
                             fontSize: 18,
                          ),),),
                    ),
                    
                  
                  ],
                ),
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
                          MaterialPageRoute(builder: (context) => myLogin()),
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
        )
  );
  }
}