import 'package:flutter/material.dart';

class MyMembers extends StatelessWidget {
  MyMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [

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
                              'MEMBERS ',
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

          ]
      ),

    );






  }
}