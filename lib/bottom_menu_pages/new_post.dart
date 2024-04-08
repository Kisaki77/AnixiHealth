import 'dart:io';
import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:health_anixi/State/new_postState.dart';
import 'package:image_picker/image_picker.dart';
>>>>>>> 4778cbb55e4fa56a6e44335a4fd7ab01590bf1dd
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/newfeed.dart';
import 'package:health_anixi/Resources/save_media.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  XFile? _imageFile;
  bool _showTagFriendsContainer = false;
  String dropdownValue = 'Visible to public'; 

  late TextEditingController _thoughtsController; // Declare TextEditingController

  @override
  void initState() {
    super.initState();
    _thoughtsController = TextEditingController(); // Initialize TextEditingController
  }

<<<<<<< HEAD
  Future<void> _pickImage() async {
=======
  // Function to allow the user to choose an image
  Future<String> _pickImage() async {
>>>>>>> 4778cbb55e4fa56a6e44335a4fd7ab01590bf1dd
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedImage;
    });

    return pickedImage!.path;
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
  // Request permission
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    print('Location permission denied.');
    return;
  }

<<<<<<< HEAD
  // Check if location service is enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print('Location services are disabled.');
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
        height: MediaQuery.of(context).size.height / 5, // Adjust the height as needed
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 217, 212, 212),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
=======
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
>>>>>>> 4778cbb55e4fa56a6e44335a4fd7ab01590bf1dd
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Tag your friends",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
                    backgroundColor: const Color.fromARGB(255, 74, 95, 86), // Change button text color to white
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Set border radius to zero
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

  Future<void> _uploadPostToFirebase() async {
    if (_imageFile == null) {
      // Handle case when no image is selected
      return;
    }

    // Upload image to Firebase Storage
    Reference ref = FirebaseStorage.instance.ref().child('Pictures/${DateTime.now().toString()}');
    UploadTask uploadTask = ref.putFile(File(_imageFile!.path));
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    // Add post data to Firestore
    await FirebaseFirestore.instance.collection('Posts').add({
      'imageUrl': imageUrl,
      'text': _thoughtsController.text, // Assuming _thoughtsController is a TextEditingController for the text input
      'timestamp': FieldValue.serverTimestamp(),
       'location' : Position,
       
      // Add other fields as needed (e.g., location, tagged friends, visibility)
    });

    // Navigate to the home page or perform any other actions after posting
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewsFeedPage()),
    );
  }

<<<<<<< HEAD
  

   @override
  void dispose() {
    _thoughtsController.dispose();
    super.dispose();
  }

=======
  Color myColor = const Color.fromARGB(255, 74, 95, 86);
  TextEditingController thoughts = TextEditingController();
>>>>>>> 4778cbb55e4fa56a6e44335a4fd7ab01590bf1dd
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // App bar configuration
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
<<<<<<< HEAD
            TextField(
              controller: _thoughtsController,
=======
            TextFormField(
              controller: thoughts,
>>>>>>> 4778cbb55e4fa56a6e44335a4fd7ab01590bf1dd
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
            SizedBox(height: 20),
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
<<<<<<< HEAD
              child: Stack(
                children: [
                  SizedBox(
                    width: 80,
                    height: 230,
                    child: _imageFile == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                color: Color.fromARGB(255, 39, 38, 38),
                              ),
                              Text(
                                'Upload a Photo',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 65, 63, 63),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          )
                        : Image.file(
                            File(_imageFile!.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                  ),
                  if (_imageFile != null) // Add the close button only if image is selected
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _imageFile = null; // Remove the selected image
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                ],
=======
              child: SizedBox(
                width: 80,
                height: 230,
                child: _imageFile == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Color.fromARGB(255, 39, 38, 38),
                          ),
                          Text(
                            'Upload a Photo',
                            style: TextStyle(
                              color: Color.fromARGB(255, 65, 63, 63),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      )
                    : Image.file(
                        File(_imageFile!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
>>>>>>> 4778cbb55e4fa56a6e44335a4fd7ab01590bf1dd
              ),
            ),
            SizedBox(height: 25),
            GestureDetector(
              onTap: _shareLocation, // Call _shareLocation when tapped
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 50, // Adjust the height as needed
                child: Row(
                  children: [
                    Icon(Icons.location_on, size: 30,  color:  Color.fromARGB(255, 53, 52, 52)),
                    SizedBox(width: 10),
                    Text(
                      'Click to share location',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
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
                    Icon(Icons.person_add, size: 30, color:  Color.fromARGB(255, 53, 52, 52)),
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
<<<<<<< HEAD
              onTap: () {
                // Handle dropdown visibility
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/flowerblack.png',
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Visible to public', 'Visible to Friends only'] // Add your dropdown items here
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: const Color.fromARGB(255, 53, 52, 52)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25,),
            ElevatedButton(
              onPressed: _uploadPostToFirebase, // Call _uploadPostToFirebase when button is pressed
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 74, 95, 86), // Change button text color to white
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Set border radius here
                ),
              ),
              child: Text(
                ' POST',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
=======
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
                        extension: "png");
                    setState(() {
                      _imageFile = null;
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
>>>>>>> 4778cbb55e4fa56a6e44335a4fd7ab01590bf1dd
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
