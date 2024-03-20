import 'package:anixii_health/pages/login.dart';
import 'package:flutter/material.dart';

class guideThree extends StatelessWidget {
  const guideThree({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
  body: Stack(
    children: [
      // Background Image with rounded corners
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: MediaQuery.of(context).size.height / 2, // Adjust the height as needed
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40), // Adjust the radius as needed
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/guide.png'),
          ),
        ),
      ),
   Positioned(
        top: MediaQuery.of(context).size.height / 2 + 40, // Adjust the position as needed
        left: 0,
        right: 0,
        child: const Padding(
          padding: EdgeInsets.only(left: 30, bottom: 20), // Adjust the padding as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Almost done',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 89, 111, 105),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Lets sign you up',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 75, 85, 84),
                ),
              ),
              SizedBox(height: 20), // Add some space between the two paragraphs
              Text(
                'Create posts, share your stories, inspire and\nsupport people like youself. Learn more about\nthe various chronic diseases and tech others\nin the community. Click Next to sign up and create\n your profile.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 75, 85, 84),
                ),
              ),
              
            ],
          ),
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
                          MaterialPageRoute(builder: (context) => myLogin()),
                        );
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: Color.fromARGB(255, 68, 90, 81),
                       
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
                 
                      Positioned(
            left: 0,
            right: 0,
            bottom: 20, // Adjust the position as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildDot(0),
                SizedBox(width: 10), // Adjust the space between dots as needed
                buildDot(1),
                SizedBox(width: 10), // Adjust the space between dots as needed
                buildDot(2),
                SizedBox(width: 10), // Adjust the space between dots as needed
                buildDot(3),]
            )
    
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
                        "Skip",
                        style: TextStyle(
                          color: Color.fromARGB(255, 68, 90, 81),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                      )
                    ),
            ) 
    ] 
    ),
                      
      );
    
  }  
}
 Widget buildDot(int index) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: guideThree() == index ? Color.fromARGB(255, 31, 54, 47) : Color.fromARGB(255, 202, 211, 206), // Change color based on current page
      ),
    );
  }