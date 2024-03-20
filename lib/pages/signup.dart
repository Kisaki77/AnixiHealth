import 'package:anixii_health/firebase_auth/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MySignUp extends StatefulWidget {  
  const MySignUp({Key? key}) : super(key: key);


  @override
  State<MySignUp> createState() => _MySignUpState();
}

  class _MySignUpState extends State<MySignUp> {
    final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

   @override
  void dispose() {
    
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
     
  // Get auth service
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              color: const Color.fromARGB(255, 74, 95, 86), 
              width: double.infinity, 
              height: double.infinity, 
            ),
              Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo Image (scrollable)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/logo.webp', 
                            width: 300,
                            height: 300,
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                    
                  
                    const SizedBox(height: 10,), 
                     Padding(
                    padding: EdgeInsets.all(10.0),
                      child: Container(
                         width: 300,
                          height: 50,
                    child: TextField(
                      controller: _emailController,
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

              
                 const SizedBox(height: 10,), 

             Padding(
                    padding: EdgeInsets.all(10.0),
                      child: Container(
                         width: 300,
                          height: 50,
                    child:  TextField(
                      controller: _passwordController,
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

             
                   const SizedBox(height: 10.0),
                  Container(
                width: 300,
                   height: 50,
                     child: SizedBox(
                 width: 300,
                height: 50,
                    child: GestureDetector(
                   onTap: () => signUp(),
                      child: const Text(
                    'Sign Up',
                   style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
    ),
  ),
),

 
          ]
        
          ),
        )
              )
          ]
        ) 
  )
    );
    

  }
  void signUp() async {
    
  
    // Get user input values
    
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await  _auth.signupWithEmailAndPassword(email, password );
    
    if (user!= null){
      print ("User Successfully signup");
      Navigator.pushNamed(context, "/login");
    } else{
      print("Some error happed");
    }
   
  

   

    // Store user data in Firestore
  }

}
 