import 'dart:io';

import 'package:flutter/material.dart';
import 'package:health_anixi/Models/UserProfile.dart';
import 'package:health_anixi/State/myProfileState.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  File? _imageFile; // Variable to store the chosen image file

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


  final List<String> genderDropdownItems = [
    'Gender',
    'Male',
    'Female',
    'Other',
  ];
  String genderDropdownValue = 'Gender';
  final List<String> provinceDropdownItems = [
    'Province',
    'Eastern Cape',
    'Free State',
    'Gauteng',
    'KwaZulu-Natal',
    'Limpopo',
    'Mpumalanga',
    'Northern Cape',
    'North West',
    'Western Cape'
  ];
  final List<String> diseaseDropdownItems = [
    'Conditions',
    'Arthritis',
    'Cancer',
    'Covid',
    'Diabetes',
    'Heart/Cardiovascular Disease',
    'HIV',
    'Kidney Disease',
    'Lung  Disease',
    'Lupus',
    'Mental Health',
    'Motor Neurone Disease',
    'Tuberculosis',
  ];
  final List<String> anotherDropdownItems = [
    'Status',
    'Warrior',
    'Survivor',
    'Supporter',
  ];
  String provinceDropdownValue = 'Province';
  String diseaseDropdownValue = 'Conditions';
  String anotherDropdownValue = 'Status';
  String city = '';
  UserProfile? profile;
  String name = "Loading";
  String? surname;
  String? cityDb;
  String? email;
  String? status;
  String? gender;
  String? province;
  String? birthday;
  String? userName;

  @override
  void initState() {
    // TODO: implement initState
    myProfileState().fetchProfileData().then((value){
      setState(() {
        profile=value;
        name = value.name!;
        surname =value.surname;
        cityDb = value.city;
        email = value.email;
        status = value.status;
        gender = value.gender;
        province = value.province;
        birthday = value.birthday;
        userName = value.userName;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return profile==null? Scaffold(
        appBar:AppBar(
          backgroundColor: Color.fromARGB(255, 254, 255, 255),
        ),
        body:Center(child: CircularProgressIndicator()
        )
    )
    :Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 254, 255, 255),
      ),
      body: Stack(
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
                  children: const [
                    Text(
                      'My Profile ',
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
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        child: ClipOval(
                          child:  _imageFile == null
                              ? Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.white,
                          )
                              : Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromARGB(255, 238, 238, 199),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 89, 134, 113),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                             name!,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 107, 165, 127)),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromARGB(255, 238, 238, 199),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.email,
                                //color: Color.fromARGB(255, 89, 134, 113),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              email!,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 107, 165, 127)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 40,
                            width: 250,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 57, 122, 103),
                            ),
                            child: const Center(
                              child: Text(
                                'Edit password',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: profile!.name,
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 57, 122, 103)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 57, 122, 103),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 57, 122, 103),
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 57, 122, 103)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: profile!.surname!,
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 57, 122, 103)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 57, 122, 103),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 57, 122, 103),
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 57, 122, 103)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: 300.0,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 57, 122, 103)),
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: SingleChildScrollView(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: profile!.gender!,
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Color.fromARGB(255, 57, 122, 103)),
                                  dropdownColor: const Color(0xff4D6159),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      genderDropdownValue = newValue!;
                                    });
                                  },
                                  items: genderDropdownItems.map((String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                            value,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 57, 122, 103))));
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: 300.0,
                            height: 50,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  city = value;
                                });
                              },
                              decoration:  InputDecoration(
                                hintText: profile!.city!,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 57, 122, 103)),
                                ),
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 57, 122, 103)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 57, 122, 103)),
                                ),
                              ),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 236, 236, 236)),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: 300.0,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 74, 100, 86)),
                              color: Color.fromARGB(255, 250, 250, 250),
                            ),
                            child: SingleChildScrollView(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: profile!.condition!,
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.white),
                                  dropdownColor: Color.fromARGB(255, 255, 255, 255),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      diseaseDropdownValue = newValue!;
                                    });
                                  },
                                  items: diseaseDropdownItems.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 61, 87, 72)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: 300.0,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 57, 122, 103)),
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: SingleChildScrollView(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: profile!.status!,
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Color.fromARGB(255, 71, 104, 86)),
                                  dropdownColor: const Color(0xff4D6159),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      anotherDropdownValue = newValue!;
                                    });
                                  },
                                  items: anotherDropdownItems.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 102, 146, 133)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 40,
                            width: 250,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 57, 122, 103),
                            ),
                            child: const Center(
                              child: Text(
                                'Edit Details',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 5),
                              Text(
                                'I want to deactivate my account',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 123, 170, 139)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
