import 'package:health_anixi/pages/guide.dart';
import 'package:health_anixi/pages/guide_three.dart';
import 'package:health_anixi/pages/login.dart';
import 'package:flutter/material.dart';

class guideTwo extends StatelessWidget {
  const guideTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Column(
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
                      image: AssetImage('assets/images/guide_2.png'),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2 -39, // Set container height
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, bottom: 100), // Adjust the padding as needed
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25),
                            Text(
                              'What we do',
                              style: TextStyle(
                                fontSize: 30,

                                color: Color.fromARGB(255, 89, 111, 105),
                              ),
                            ),
                            // Add some space between the two paragraphs
                            Text(
                              'ANIXI is a health community that support one\nanother and shares real-life experiences. It\nassists you, your family, and your friends through\n difficult times.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 75, 85, 84),
                              ),
                            ),

                            SizedBox(height: 10), // Add some space between the two paragraphs
                            Text(
                              'Join one of our 3 ANIXI categories',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 75, 85, 84),
                              ),
                            ),

                            SizedBox(height: 7), // Add some space between the two paragraphs
                            // Add icon and text for each category
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // You can change the color of the icon background here
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/Supporter icon.png', // Provide the path to your image asset here
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ), // Change the icon as needed
                                ),
                                const SizedBox(width: 10), // Add some space between the icon and text
                                const Expanded(
                                  child: Text(
                                    'Supporter\n'

                                        'You need to support a family member,\nfriend,colleague or would simply like to know more about various chronic diseases.',
                                    style: TextStyle(
                                      fontSize: 14,

                                      color: Color.fromARGB(255, 75, 85, 84),
                                    ),
                                  ),

                                ),



                              ],
                            ),
                            SizedBox(height: 10), // Add some space between the paragraphs
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // You can change the color of the icon background here
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/Soldier icon.png', // Provide the path to your image asset here
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),// Change the icon as needed
                                ),
                                SizedBox(width: 10), // Add some space between the icon and text
                                Expanded(
                                  child: Text(
                                    'Warrior\nYou are currently dealing with a chronic\ndisease and looking to join a community\nfor support from other people with similar\nconditions that can assist you through your journey.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 75, 85, 84),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10), // Add some space between the paragraphs
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // You can change the color of the icon background here
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/Survivor icon.png', // Provide the path to your image asset here
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10), // Add some space between the icon and text
                                Expanded(
                                  child: Text(
                                    'Survivor\nYou have gone through, struggled and\nsuccessfully beat your illness. You are a survivor.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 75, 85, 84),
                                    ),
                                  ),)
                              ],
                            ),
                          ]
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white, // Set your desired background color here

                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to the forgot password page
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => myLogin()),
                              );
                            },
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                color: Color.fromARGB(255, 68, 90, 81),
                                fontSize: 18,
                              ),
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

                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to the guide page
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => guideThree()),
                              );
                            },
                            child: Text(
                              "Next",
                              style: TextStyle(
                                color: Color.fromARGB(255, 68, 90, 81),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),

                )
            )

          ],
        )
    );


  }
}
Widget buildDot(int index) {
  return Container(
    width: 15,
    height: 15,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: GuidePage() == index ? Color.fromARGB(255, 31, 54, 47) : Color.fromARGB(255, 202, 211, 206), // Change color based on current page
    ),
  );
}