import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_anixi/Navigate/Wrapper.dart';
import 'package:health_anixi/pages/PaymentScreen.dart';
import 'package:health_anixi/pages/VideoUpload.dart';
import '../menu_pages/group.dart';
import '../menu_pages/invites.dart';
import '../menu_pages/member.dart';
import '../menu_pages/myprofile.dart';
import '../menu_pages/story.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({Key? key}) : super(key: key);

  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  List<bool> isLikedList = List.generate(4, (_) => false);
  List<int> likeCountList = List.generate(4, (_) => 0);
  List<List<String>> comments = List.generate(4, (_) => []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 74, 95, 86),
          child: ListView(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 74, 95, 86),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile.jpg',
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Karabo Kgwale',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 249, 252, 250),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Mental Health\n Supporter',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 249, 252, 250),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/Supporter icon.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyProfile()),
                  );
                },
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/Supporter icon.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Story',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyStory()),
                  );
                },
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/Survivor icon.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Group',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Group()),
                  );
                },
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/Soldier icon.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Members',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyMembers()),
                  );
                },
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/Supporter icon.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Invites',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Myinvites()),
                  );
                },
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/Survivor icon.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Videos',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoUpload()),
                  );
                },
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    'assets/images/Survivor icon.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  'Donate',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                 /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()),
                  );*/
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  _signOut();
                },
              ),
              // Add the Sign Out ListTile here
            ],
          ),
        ),
      ),
      body: Builder(
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
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    backgroundColor: const Color(0xff4D6159),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Image.asset(
                      'assets/images/iconfeed.png',
                      width: 90,
                      height: 55,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'NEWS FEED',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(Icons.menu, color: Colors.white),
                ),
                const SizedBox(width: 20), // Adjust the space as needed
              ],
            ),
          ),
             Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height / 10,
                  child: Stack(
                    children: [
                      ClipRRect(
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
                                offset: const Offset(0, -3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/flowerblack.png',
                                        width: 100,
                                        height: 70,
                                      ),
                                      Positioned(
                                        top: -15,
                                        child: GestureDetector(
                                          onTap: () {
                                            _displayHiddenContainer(context);
                                          },
                                          child: const Icon(
                                            Icons.expand_less,
                                            size: 40,
                                            color: Colors
                                                .grey, // Adjust the color as needed
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.notifications,
                                    size: 50,
                                    color: Color.fromARGB(255, 129, 104,
                                        27), // Adjust the color as needed
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 10 + 20,
                  bottom: MediaQuery.of(context).size.height / 10 + 20,
                  left: 0,
                  right: 0,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Posts")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      final mediaList = snapshot.data?.docs.reversed.toList();
                      return ListView.builder(
                        itemCount: mediaList?.length,
                        itemBuilder: (context, index) {
                          final media = mediaList![index];
                          //final videoController = VideoPlayerController.network(video["Url"]);
                          //_controllers.add(videoController);
                          // return Card(
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: VideoListItem(
                          //       videoController: videoController,
                          //       videoName: video["Name"],
                          //     ),
                          //   ),
                          // );
                          return _buildNewsCard(context, media["Thoughts"], index,media["Media"]);
                        },
                      );
                    },
                    // child: ListView(
                    //   children: [
                    //     _buildNewsCard(context, 'News 1', 0),
                    //_buildNewsCard(context, 'News 2', 1),
                    //     _buildNewsCard(context, 'News 3', 2),
                    //     _buildNewsCard(context, 'News 4', 3),
                    //   ],
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, String title, int index,String url) {
    return Card(
      color: Colors.grey[200],
      child: Column(
        children: [
          ListTile(
            title: Text(title),
          ),
          Container(
            color: Colors.white,
            height: 200,
            width: 400,
            child: Card(
              color: Colors.white,
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
              child: Image.network(
                url,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLikedList[index] = !isLikedList[index];
                    if (isLikedList[index]) {
                      likeCountList[index]++;
                    } else {
                      //likeCountList[index]--;
                    }
                  });
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/hearty.png',
                      width: 20,
                      height: 20,
                      color: isLikedList[index] ? Colors.red : null,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      ' ${likeCountList[index]} Reacts',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  _showCommentDialog(context, index);
                },
                child: const Text(
                  'Comment',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _handleShareAction();
                },
                child: const Text(
                  'Share',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (comments[index].isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Comment: ${comments[index]}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNewsCardVideo(BuildContext context, String title, int index,String url) {
    return Card(
      color: Colors.grey[200],
      child: Column(
        children: [
          ListTile(
            title: Text(title),
          ),
          Container(
            color: Colors.white,
            height: 200,
            width: 400,
            child: Card(
              color: Colors.white,
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
              child: Image.network(
                url,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLikedList[index] = !isLikedList[index];
                    if (isLikedList[index]) {
                      likeCountList[index]++;
                    } else {
                      //likeCountList[index]--;
                    }
                  });
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/hearty.png',
                      width: 20,
                      height: 20,
                      color: isLikedList[index] ? Colors.red : null,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      ' ${likeCountList[index]} Reacts',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  _showCommentDialog(context, index);
                },
                child: const Text(
                  'Comment',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _handleShareAction();
                },
                child: const Text(
                  'Share',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (comments[index].isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Comment: ${comments[index]}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showCommentDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newComment = "";

        return AlertDialog(
          title: const Text("Add a Comment"),
          content: TextField(
            onChanged: (value) {
              newComment = value;
            },
            decoration: const InputDecoration(hintText: "Enter your comment"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  comments[index].add(newComment);
                });
                Navigator.of(context).pop();
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  void _handleShareAction() {
    // Implement your sharing logic here
  }

  void _displayHiddenContainer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 217, 212, 212),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              child: const Icon(
                Icons.expand_more,
                size: 40,
                color: Colors.grey, // Adjust the color as needed
              ),

            ),


              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildClickableCircularImageWithText(
                    context,
                    'assets/images/friends.png',
                    'Friends',
                    '/friends',
                  ),
                  const SizedBox(width: 16),
                  _buildClickableCircularImageWithText(
                    context,
                    'assets/images/post.png',
                    'New post',
                    '/new_post',
                  ),
                  const SizedBox(width: 16),
                  _buildClickableCircularImageWithText(
                    context,
                    'assets/images/messenger.png',
                    'Messages',
                    '/messages',
                  ),
                  const SizedBox(width: 16),
                  _buildClickableCircularImageWithText(
                    context,
                    'assets/images/belle.png',
                    'Notifications',
                    '/notifications',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(
                color: Colors.black,
                thickness: 1.0,
              ),
              Image.asset(
                'assets/images/flowerblack.png',
                width: 100,
                height: 80,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildClickableCircularImageWithText(
      BuildContext context, String imagePath, String text, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              imagePath,
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 102, 105, 103),
            ),
          ),
        ],
      ),
    );
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      Navigator.of(context).popUntil((route) => route.isFirst);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Wrapper();
      }));

    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
