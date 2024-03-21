import 'package:flutter/material.dart';

class NewsFeedPage extends StatelessWidget {
  const NewsFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 74, 95, 86),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 74, 95, 86),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile.jpg', // Path to your image asset
                          fit: BoxFit.cover,
                          width: 100, // Adjust as needed
                          height: 100, // Adjust as needed
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Luwe Xaba',
                      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 249, 252, 250)),
                    ),
                    SizedBox(height: 10),
                    const Text(
                      'Kidney Disease\n Warrior',
                      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 249, 252, 250)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/Supporter icon.png', // Provide the path to your image asset here
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Profile',
                  style: TextStyle(fontSize: 15, color: Colors.white,),
                ),
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()), );
                },
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/Supporter icon.png', // Provide the path to your image asset here
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Story',
                  style: TextStyle(fontSize: 15,  color: Colors.white,),
                ),
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => MyStory()), );
                },
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/Survivor icon.png', // Provide the path to your image asset here
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  'Group',
                  style: TextStyle(fontSize: 15, color: Colors.white,),
                ),
                onTap: (){
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => Group()), );
                },
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/Soldier icon.png', // Provide the path to your image asset here
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  'Members',
                  style: TextStyle(fontSize: 15, color: Colors.white,),
                ),
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => MyMembers()), );
                },
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/Supporter icon.png', // Provide the path to your image asset here
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  'Invites',
                  style: TextStyle(fontSize: 15, color: Colors.white,),
                ),
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Myinvites()), );
                },
              ),

            ],
          ),
        ),
      ),
      body: Builder( // Added Builder widget here
        builder: (context) => Center(
          child: Padding(
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
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    child: Container(
                      color: const Color(0xff4D6159),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Image.asset(
                              'assets/images/iconfeed.png',
                              width: 100,
                              height: 150,
                              color: Colors.white,
                            ),
                          ),

                          const Text(
                            'NEWS FEED',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          // menu sidebar icon

                          GestureDetector(
                            onTap: () {
                              Scaffold.of(context).openEndDrawer(); // Open the end drawer when tapped
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Image.asset(
                                'assets/images/Iconmenu.png',
                                width: 100,
                                height: 150,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height / 10,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 217, 212, 212),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: Offset(0, -3), // changes position of shadow
                          ),
                        ],
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Image.asset(
                              'assets/images/flowerblack-02.png', // Adjust the image path as needed
                              width: 150, // Adjust the width of the image
                              height: 80, // Adjust the height of the image
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Image.asset(
                              'assets/images/bell.png', // Adjust the image path as needed
                              width: 100, // Adjust the width of the image
                              height: 50, // Adjust the height of the image
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
        ),
      ),
    );
  }
}

