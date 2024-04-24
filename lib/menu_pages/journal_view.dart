import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'journal_list.dart';

class Journalview extends StatefulWidget {
  final String title;
  final String details;
  final String imageUrl;
  final DateTime time;
  final String documentId;

  Journalview({
    required this.title,
    required this.details,
    required this.imageUrl,
    required this.time,
    required this.documentId,
  });

  @override
  State<Journalview> createState() => _JournalviewState();
}

class _JournalviewState extends State<Journalview> {
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
      body: JournalviewBody(
        title: widget.title,
        details: widget.details,
        imageUrl: widget.imageUrl,
        time: widget.time,
        documentId: widget.documentId,
      ),
    );
  }
}

class JournalviewBody extends StatefulWidget {
  final String title;
  final String details;
  final String imageUrl;
  final DateTime time;
  final String documentId;

  JournalviewBody({
    required this.title,
    required this.details,
    required this.imageUrl,
    required this.time,
    required this.documentId,
  });

  @override
  _JournalviewBodyState createState() => _JournalviewBodyState();
}

class _JournalviewBodyState extends State<JournalviewBody> {
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

  Future<void> _updateJournalEntry(String newTitle, String newDetails) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String imageUrl = widget.imageUrl; // Default to the current image URL

        // Upload new image to Firebase Storage if a new image is selected
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

        // Update journal entry in Firestore
        await FirebaseFirestore.instance
            .collection('journals')
            .doc(widget.documentId)
            .update({
          'title': newTitle,
          'details': newDetails,
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
                    padding: EdgeInsets.all(4), // Add padding to the container
                    child: Image.asset(
                      'assets/images/flowerblack.png',
                      width: 24, // Adjust width as needed
                      height: 24, // Adjust height as needed
                    ),
                  ),
                  SizedBox(
                      width: 8), // Add some space between the image and text
                  Text('Entry updated successfully'),
                ],
              ),
            ),
          ),
        );

        // Navigate to the Journal List page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Journallist(),
          ),
        );
      } else {
        // User is not logged in, handle accordingly
      }
    } catch (e) {
      // Handle error
      print('Error updating journal entry: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Clear the text fields before setting initial values
    _titleController.clear();
    _detailsController.clear();
    // Set the initial values for title and details
    _titleController.text = widget.title;
    _detailsController.text = widget.details;
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
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 100,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(126, 202, 204, 205),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        child: _imageFile == null
                            ? widget.imageUrl == null
                                ? Icon(
                                    Icons.image,
                                    size: 100,
                                    color: const Color(0xff4D6159),
                                  )
                                : Image.network(
                                    widget.imageUrl,
                                    fit: BoxFit.cover,
                                  )
                            : Image.file(
                                _imageFile!,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff4D6159),
                    letterSpacing: 0.1,
                  ),
                ),
              ),
              TextFormField(
                textAlign: TextAlign.left,
                controller: _titleController,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  // hintText: widget.title,
                  hintStyle: TextStyle(fontSize: 12),
                  contentPadding:
                      EdgeInsets.only(left: 10.0, top: 3.0, bottom: 5.0),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff4D6159),
                    letterSpacing: 0.1,
                  ),
                ),
              ),
              TextFormField(
                textAlign: TextAlign.left,
                controller: _detailsController,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  // hintText: widget.details,
                  hintStyle: TextStyle(fontSize: 12),
                  contentPadding:
                      EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Call _updateJournalEntry method if the form is valid
                        _updateJournalEntry(
                          _titleController.text,
                          _detailsController.text,
                        );
                      }
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      minimumSize: Size(160, 40),
                      backgroundColor: Color(0xff4D6159),
                    ),
                  ),
                  SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Navigate back without saving changes
                    },
                    child: Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      minimumSize: Size(160, 40),
                      backgroundColor: Color.fromARGB(126, 202, 204, 205),
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
