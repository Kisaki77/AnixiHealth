import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'journal_details.dart';
import 'journal_view.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Journallist extends StatelessWidget {
  const Journallist({Key? key});

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
              'JOURNAL LIST',
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
      body: JournallistBody(),
    );
  }
}

class JournallistBody extends StatefulWidget {
  @override
  State<JournallistBody> createState() => _JournallistBodyState();
}

class _JournallistBodyState extends State<JournallistBody> {
  late List<DocumentSnapshot> journals = []; // Initialize with an empty list

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  void initState() {
    super.initState();
    // Fetch data from Firestore and assign it to journals
    fetchJournals();
  }

  Future<void> fetchJournals() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('journals')
          .orderBy('time', descending: true)
          .get();
      setState(() {
        journals = querySnapshot.docs;
      });
    } catch (e) {
      print('Error fetching journals: $e');
    }
  }

  Future<String> getDownloadUrl(String gsUrl) async {
    final Reference ref = FirebaseStorage.instance.refFromURL(gsUrl);
    final String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                'MY JOURNALS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4D6159),
                ),
              ),
              SizedBox(width: 80),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Journaldetails(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'CREATE',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff4D6159), // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(50), // Button border radius
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: journals.length,
              itemBuilder: (context, index) {
                // Extract journal data from the document snapshot
                Map<String, dynamic> data =
                    journals[index].data() as Map<String, dynamic>;

                // Replace placeholders with actual data
                String title = data['title'] ?? 'Untitled';
                String details = data['details'] ?? '';
                String gsImageUrl = data['imageUrl'] ?? ''; // GCS image URL
                DateTime time =
                    (data['time'] as Timestamp).toDate() ?? DateTime.now();
                String documentId = journals[index].id; // Get the document ID

                // Get download URL for the GCS image
                return FutureBuilder(
                  future: getDownloadUrl(gsImageUrl),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show loading indicator while fetching download URL
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Show error message if download URL retrieval fails
                      return Text('Error loading image');
                    } else {
                      String imageUrl = snapshot.data.toString();
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the journal details page and pass necessary data
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Journalview(
                                title: title,
                                details: details,
                                imageUrl: imageUrl,
                                time: time,
                                documentId: documentId, // Pass documentId here
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey, // Grey color
                                  width: 1.0, // 1 pixel width
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0,
                                  top:
                                      8.0), // Adjust the left padding as needed
                              child: Row(
                                children: [
                                  // Picture on the left
                                  Container(
                                    width: 100,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors
                                          .white, // Add white background color here
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Add border radius
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: imageUrl.isNotEmpty
                                          ? Image.network(
                                              imageUrl,
                                              fit: BoxFit
                                                  .cover, // Fill the container without stretching the image
                                            )
                                          : Icon(
                                              Icons.image), // Placeholder icon
                                    ),
                                  ),

                                  SizedBox(width: 16),
                                  // Title, date & time, and view entry button on the right
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          '${time.day} ${months[time.month - 1]} at ${time.hour}:${time.minute}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          'View Entry',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff4D6159),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
