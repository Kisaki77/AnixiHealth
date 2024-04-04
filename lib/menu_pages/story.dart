import 'package:flutter/material.dart';

class MyStory extends StatelessWidget {
  const MyStory({super.key});

  @override
  Widget build(BuildContext context) {

    Color myColor = const Color.fromARGB(255, 74, 95, 86);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Soldier icon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 90, // Adjust the bottom position as needed
            left: 140,
            right: 20, // Adjust the left position as needed
            child: Row(

                children: [
                  CircleAvatar(
                    radius: 60,

                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile.jpg', // Path to your image asset
                        fit: BoxFit.cover,
                        width: 1500, // Adjust as needed
                        height: 150, // Adjust as needed
                      ),
                    ),
                  ),
                ]
            ),

          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height / 10,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Container(
                      color: const Color(0xff4D6159),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          const Text(
                            'My Story ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            top: MediaQuery.of(context).size.height / 4 + 30, // Adjust top position
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),  // Optional border for visual clarity
                      ),
                      child: TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Type here...',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue), // Set the border color here
                            borderRadius: BorderRadius.circular(10), // Optional: adjust border radius as needed
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255)), // Set the border color when enabled (not focused)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255)), // Set the focused border color here
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        ),
                      )

                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(

                  child: Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 73, 117, 95), // Background color
                      borderRadius: BorderRadius.circular(0), // Rounded corners
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Color.fromARGB(255, 251, 255, 253), // Text color
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}