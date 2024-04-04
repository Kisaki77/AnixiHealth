import 'package:health_anixi/groups/Covid.dart';
import 'package:health_anixi/groups/Diabetes.dart';
import 'package:health_anixi/groups/HivGroup.dart';
import 'package:health_anixi/groups/Motor.dart';
import 'package:health_anixi/groups/heart.dart';
import 'package:flutter/material.dart';



class Group extends StatelessWidget {


  final List<Map<String, String>> imagesWithLabels = [
    {'image': 'assets/images/motor.jpg', 'label': 'Motor Neuron Disease'},
    {'image': 'assets/images/HIV.webp', 'label': 'HIV'},
    {'image': 'assets/images/heart attack.webp', 'label': 'Heart/ Cardiovascular Disease'},
    {'image': 'assets/images/diabetes.jpg', 'label': 'Diabetes'},
    {'image': 'assets/images/covid.jpg', 'label': 'Covid'},
    {'image': 'assets/images/guide_2.png', 'label': 'Cancer'},
    {'image': 'assets/images/guide.png', 'label': 'Arthritis'},
    {'image': 'assets/images/guide_2.png', 'label': 'Kidney Disease'},
    {'image': 'assets/images/guide.png', 'label': 'Arthritis'},
    // Add more image paths and labels here
  ];




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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),

                          ),
                          const Text(
                            'OUR Group ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Scaffold.of(context).openEndDrawer();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),

                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: imagesWithLabels.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        navigateToPage(context, index); // Navigate to the image details page
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Card(
                            margin: const EdgeInsets.all(8.0),
                            child: Image.asset(

                              imagesWithLabels[index]['image']!,
                              width: double.infinity,
                              height: 130, // Adjust height as needed
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 8.0, // Adjust the bottom offset as needed
                            left: 8.0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),

                              child: Text(
                                imagesWithLabels[index]['label']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
void navigateToPage(BuildContext context, int index) {
  // Example navigation logic based on the index
  switch (index) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Motor(),
        ),
      );
      break;
    case 1:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HIVPage(),
        ),
      );
      break;
    case 2:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const heartGroup(),
        ),
      );
      break;
    case 3:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Diabetes(),
        ),
      );
      break;
    case 4:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Covid(),
        ),
      );
      break;
    default:
    // Handle other cases if needed
      break;
  }
}




