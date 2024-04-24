import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'journal_list.dart';

class Journaldetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: const Color(0xff4D6159),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0, // Remove elevation
            title: const Text(
              'JOURNAL DETAILS',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset(
                  'assets/images/back.png',
                  width: 18,
                  height: 18,
                ),
              ),
            ),
          ),
        ),
      ),
      body: JournaldetailsBody(),
    );
  }
}

class JournaldetailsBody extends StatefulWidget {
  @override
  _JournaldetailsBodyState createState() => _JournaldetailsBodyState();
}

class _JournaldetailsBodyState extends State<JournaldetailsBody> {
  File? _imageFile; // Variable to store the chosen image file
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  // Function to allow the user to choose an image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      }
    });
  }

  // Function to show a custom dialog
  void _showCustomDialog(String message, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Define the duration for the dialog to be displayed
        const duration = Duration(seconds: 3);

        // Show the dialog
        Future.delayed(duration, () {
          Navigator.of(context).pop(true); // Pop the dialog after 5 seconds
        });

        return Dialog(
          backgroundColor:
              Color.fromARGB(118, 0, 0, 0), // Grey background color
          elevation: 0, // Remove elevation
          insetPadding: EdgeInsets.all(5), // Adjust inset padding
          child: SizedBox(
            width: 50, // Adjust the width as needed
            child: Container(
              padding: EdgeInsets.all(5), // Adjust padding
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/flowerblack.png',
                    width: 50,
                    height: 50,
                    color: Colors.white, // Color of the image
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16, color: Colors.white), // Text color
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// Define the URL for the default image
  static String defaultImageUrl =
      'gs://anixii-project.appspot.com/Images/no_image.png';

// Modify the _saveJournalEntry method to navigate to the Journal List page after saving the entry
  Future<void> _saveJournalEntry() async {
    try {
      if (_formKey.currentState!.validate()) {
        // Form is valid, continue with saving

        // Get the current user
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          String imageUrl = defaultImageUrl; // Default to the default image URL

          // Upload image to Firebase Storage if an image is selected
          if (_imageFile != null) {
            // Generate a unique filename
            String fileName = DateTime.now().millisecondsSinceEpoch.toString();

            // Reference to the location where the image will be uploaded in Firebase Storage
            Reference ref =
                FirebaseStorage.instance.ref().child('images').child(fileName);

            // Upload image file
            UploadTask uploadTask = ref.putFile(_imageFile!);

            // Get download URL of the uploaded image
            TaskSnapshot taskSnapshot = await uploadTask;
            imageUrl = await taskSnapshot.ref.getDownloadURL();
          }

          // Save journal entry to Firestore with user ID
          await FirebaseFirestore.instance.collection('journals').add({
            'title': _titleController.text,
            'details': _detailsController.text,
            'imageUrl': imageUrl,
            'time': DateTime.now(),
            'userId': user.uid, // Add the user's ID
          });

          // Show success message with an image in the SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(72, 0, 0, 0), // Set background color
                  borderRadius: BorderRadius.circular(15), // Set border radius
                ),
                padding: EdgeInsets.all(8), // Add padding to the container
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255,
                            255), // Set transparent color for container
                        borderRadius:
                            BorderRadius.circular(15), // Set border radius
                      ),
                      padding:
                          EdgeInsets.all(4), // Add padding to the container
                      child: Image.asset(
                        'assets/images/flowerblack.png',
                        width: 24, // Adjust width as needed
                        height: 24, // Adjust height as needed
                      ),
                    ),
                    SizedBox(
                        width: 8), // Add some space between the image and text
                    Text('Entry saved successfully'),
                  ],
                ),
              ),
            ),
          );

          // Navigate to the Journal List page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Journallist()),
          );
        } else {
          // User is not logged in, handle accordingly
        }
      }
    } catch (e) {
      // Handle error
      print('Error saving journal entry: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
        child: Form(
          key: _formKey, // Assign form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Choose Image button
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 100, // Adjust width as needed
                  height: 230, // Adjust height as needed
                  decoration: BoxDecoration(
                    color:
                        Color.fromARGB(126, 202, 204, 205), // Background color
                    borderRadius: BorderRadius.circular(20), // Border radius
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.zero,
                          image: _imageFile != null
                              ? DecorationImage(
                                  image: FileImage(_imageFile!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _imageFile == null
                            ? Icon(
                                Icons.image,
                                size: 100,
                                color: const Color(0xff4D6159),
                              )
                            : null,
                      ),
                      SizedBox(height: 10),
                      if (_imageFile == null)
                        Text(
                          'Upload a Photo',
                          // Text displayed underneath the image
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Text and TextFormField for Title
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  ' T i t l e', // Add space between letters
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff4D6159),
                      letterSpacing: 0.1), // Add letterSpacing property
                ),
              ),
              TextFormField(
                textAlign: TextAlign.left,
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _showCustomDialog('Enter Title', 'Image');
                    return null; // Return null instead of error message
                  }
                  return null;
                },
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  hintText: ' Title',
                  hintStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.only(
                    left: 10.0,
                    top: 3.0,
                    bottom: 5.0,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Text and TextFormField for Details
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  ' D e t a i l s', // Add space between letters
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff4D6159),
                      letterSpacing: 0.1), // Add letterSpacing property
                ),
              ),
              TextFormField(
                textAlign: TextAlign.left,
                controller: _detailsController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _showCustomDialog('Enter Details', 'Image');
                    return null;
                  }
                  return null;
                },
                maxLines: 6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  hintText: 'Details',
                  hintStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.only(
                    left: 10.0,
                    top: 8.0,
                    bottom: 8.0,
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Call _saveJournalEntry method if the form is valid
                        _saveJournalEntry();
                      }
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      minimumSize:
                          Size(160, 40), // Set the minimum width and height
                      backgroundColor:
                          Color(0xff4D6159), // Set the background color
                    ),
                  ),
                  SizedBox(width: 30), // Add some space between the buttons
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Journallist(),
                        ),
                      );
                    },
                    child: Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      minimumSize:
                          Size(160, 40), // Set the minimum width and height
                      backgroundColor: Color.fromARGB(
                          126, 202, 204, 205), // Set the background color
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
