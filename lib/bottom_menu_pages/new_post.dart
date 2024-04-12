import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health_anixi/State/new_postState.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../pages/newfeed.dart';
import 'package:health_anixi/Resources/save_media.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  XFile? _imageFile; // Variable to store the chosen image file
  XFile? _videoFile;
  bool _showTagFriendsContainer = false;
  VideoPlayerController? videoController;

  // Function to allow the user to choose an image
  Future<String> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedImage;
    });

    return pickedImage!.path;
  }

  // Function to allow the user to choose a video
  Future<String> _pickVideo() async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _videoFile = pickedVideo;
    });

    return pickedVideo!.path;
  }




  void _shareLocation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Permission"),
          content: Text("Allow AnixiHealth to access this device's location?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _getLocation();
              },
              child: Text("Allow"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Deny"),
            ),
          ],
        );
      },
    );
  }

  void _getLocation() async {
    // Check if location service is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    // Request permission
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permission denied.');
      return;
    }

    try {
      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      // Use position.latitude and position.longitude to share location
    } catch (e) {
      print('Failed to get location: $e');
    }
  }

  void _displayHiddenContainer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height /
              5, // Adjust the height as needed
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Tag your friends",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey, // Change divider color to grey
                thickness: 1.0,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 74, 95, 86), // Change button text color to white
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.zero, // Set border radius to zero
                      ),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color myColor = const Color.fromARGB(255, 74, 95, 86);
  TextEditingController thoughts = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    videoController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4D6159),
        title: const Text(
          'CREATE POST',
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
              MaterialPageRoute(
                builder: (context) => NewsFeedPage(),
              ),
            );
          },
          child: Image.asset(
            'assets/images/back.png', // Replace 'assets/images/back.png' with your actual image path
            width: 20, // Adjust width as needed
            height: 40, // Adjust height as needed
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: thoughts,
              decoration: InputDecoration(
                hintText: 'Share your thoughts',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.all(20),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                          title:Center(
                            child: Text(
                                'What do you want to upload?',
                                style:TextStyle(
                                  color: myColor,
                                  fontWeight: FontWeight.bold,

                                )
                            ),
                          ),
                          // content: Text(
                          //   "Please choose Media Type",
                          //   style: TextStyle(
                          //       color: myColor
                          //   ),
                          // ),
                          actions:<Widget>[
                            TextButton(
                                onPressed:() async {
                                  await _pickImage();
                                  Navigator.of(context).pop();//
                                },
                                child:Center(
                                  child: Text(
                                      "Image",
                                      style:TextStyle(
                                        fontSize:20,
                                          color: Colors.black,
                                          //fontWeight: FontWeight.bold
                                      )
                                  ),
                                )
                            ),
                            TextButton(
                                onPressed:()async{
                                 await _pickVideo();
                                  _intializeVideoPlayer();
                                  Navigator.of(context).pop();

                                },
                                child:Center(
                                  child: Text(
                                      "Video",
                                      style:TextStyle(
                                        fontSize:20,
                                          color: Colors.black,
                                          //fontWeight: FontWeight.bold
                                      )
                                  ),
                                )
                            )
                          ]

                      );
                    }
                );
              },
              child: Text("Upload Media"),
            ),
            ElevatedButton(
              onPressed: () async {
                _pickImage();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: const Color.fromARGB(255, 180, 178, 178),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: SizedBox(
                width: 150,
                height: 230,
                child: _imageFile== null && _videoFile==null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Color.fromARGB(255, 39, 38, 38),
                          ),
                          Text(
                            'Upload Media',
                            style: TextStyle(
                              color: Color.fromARGB(255, 65, 63, 63),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      )
                    : _videoFile !=null?
                _videoPreviewWidget():

                Image.file(
                        File(_imageFile!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                ,
              ),
            ),


            const SizedBox(height: 25),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Add Hyperlink',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                prefixIcon: Icon(Icons.link, size: 30),
              ),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: _shareLocation, // Call _shareLocation when tapped
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 50, // Adjust the height as needed
                child: Row(
                  children: [
                    Icon(Icons.location_on, size: 30, color: Colors.black),
                    SizedBox(width: 10),
                    Text(
                      'Click to share location',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showTagFriendsContainer = !_showTagFriendsContainer;
                });
                _displayHiddenContainer(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: Row(
                  children: [
                    Icon(Icons.person_add, size: 30, color: Colors.black),
                    SizedBox(width: 10),
                    Text(
                      'Type to tag your friends',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                try {
                  if (_imageFile != null) {
                   String url = await  new_postState().saveMedia(
                        media: _imageFile!.path,
                        mediaType: "Picture",
                        extension: "png"
                    );

                    await new_postState().submitPost(
                        thoughts: thoughts.text,
                        location: "Ladysmith",
                        media: url,
                        mediaType: "Picture",
                        extension: "png",
                    );
                    setState(() {
                      _imageFile = null;
                    });
                  }
                  else if (_videoFile != null) {
                    String url = await  new_postState().saveMedia(
                        media: _videoFile!.path,
                        mediaType: "Video",
                        extension: "mp4"
                    );



                    // Creates video Thumbnail
                    String? thumbnail = await VideoThumbnail.thumbnailFile(
                      video: url,
                    );

                    // Saves thumbnail to Firebase storage
                    String? thumbnailData = await  new_postState().saveMedia(
                        media: thumbnail!,
                        mediaType: "Picture",
                        extension: "png"
                    );


                    await new_postState().submitPost(
                        thoughts: thoughts.text,
                        location: "Ladysmith",
                        media: url,
                        mediaType: "Video",
                        extension: "mp4",
                      thumbnail: thumbnailData
                    );
                    setState(() {
                      _videoFile = null;
                    });
                  }
                }
                catch(e){

                }
              },
              child: Container(
                height: 55,
                width: 300,
                decoration: BoxDecoration(
                  color: myColor, // Background color
                  borderRadius: BorderRadius.circular(0), // Rounded corners
                ),
                child: Center(
                  child: Text(
                    'Submit Post',
                    style: TextStyle(
                      color: Colors.white, // Text color
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
    );
  }

  void _intializeVideoPlayer(){

    videoController = VideoPlayerController.file(
        File(_videoFile!.path))
      ..initialize().then((value){
        setState(() {
          videoController!.play();
        });
      });

  }

  Widget _videoPreviewWidget(){
    if(videoController !=null){
      return Column(
        children: [
          AspectRatio(
              aspectRatio: videoController!.value.aspectRatio,
              child:VideoPlayer(videoController!)
          ),SizedBox(
            height: 10,
          ),Padding(
            padding: const EdgeInsets.all(20),

          ),
          SizedBox(
            height: 20,
          )
        ],
      );
    }
    else{
      return const CircularProgressIndicator();
    }

  }
}

