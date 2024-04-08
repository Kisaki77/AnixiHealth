import 'package:flutter/material.dart';


import '../pages/newfeed.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4D6159),
        title: const Text(
          'FRIENDS',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true, // Aligns the title text in the center
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsFeedPage()), // Replace NewsfeedPage() with your actual Newsfeed page widget
            );
          },
          child: Image.asset(
            'assets/images/back.png', // Replace 'assets/images/back.png' with your actual image path
            width: 20, // Adjust width as needed
            height: 20, // Adjust height as needed
          ),
        ),
      ),
      
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Add action for the friends button here
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff4D6159)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Removes the button radius
                      ),
                    ),
                  ),
                  child: const Text(
                    'FRIENDS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add  action for the requests button here
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Removes the button radius
                      ),
                    ),
                  ),
                  child: const Text(
                    'REQUESTS',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
         const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'FIND FRIENDS',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                suffixIcon: Icon(Icons.search),
                 // Move the search icon to the right side
              ),
              
            ),
          ),


        ],
      ),
    );
  }
}
