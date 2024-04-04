import 'package:flutter/material.dart';

class HIVPage extends StatelessWidget {
  const HIVPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/HIV.webp'),
                  fit: BoxFit.cover,
                ),
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
                              'OUR Group ',
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
              top: 200, // Adjust the bottom position as needed
              left: 20,
              right: 20, // Adjust the left position as needed
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'HIV',
                      style: TextStyle(
                        fontSize: 18,

                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          // Add onPressed functionality for the button
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 77, 119, 106), // Background color


                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Button padding
                        ),
                        child: Text(
                            'Join Community',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )
                        )



                    )

                  ]

              ),
            ),
          ]
      ),

    );






  }
}