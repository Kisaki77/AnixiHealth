import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
            image: AssetImage('assets/images/guide_1.png'),
          ),
        ),
      ),
   Positioned(
        top: MediaQuery.of(context).size.height / 2 + 40, // Adjust the position as needed
        left: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 20), // Adjust the padding as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to NewsFeed Page',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 89, 111, 105),
                ),
              ),
            ]
              )
        )
   )
    ]
  )
  );

  }
}