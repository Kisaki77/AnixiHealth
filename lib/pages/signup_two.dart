import 'package:flutter/material.dart';

import 'signup_three.dart';

class SignTwoPage extends StatefulWidget {
  late String uid;
  SignTwoPage({required this.uid});

  @override
  State<SignTwoPage> createState() => _SignTwoPageState();
}

class _SignTwoPageState extends State<SignTwoPage> {

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
  //dropdown list for conditions
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
  //dropdown list for status
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

  @override
  Widget build(BuildContext context) {
    print("Entered Signup 2222222: uid is ${widget.uid}");
    return Scaffold(
      body: Container(
        color: const Color(0xff4D6159), // Background color
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/Anixihealth.png', // Replace 'logo.png' with your logo image path
                height: 300,
                width: 500,
                //fit: BoxFit.cover, // Adjust as needed
              ),
              const SizedBox(
                  height: 20.0), // Spacer between logo and other widgets
              Container(
                width: 300.0, // Adjust width as needed
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: provinceDropdownValue,
                    icon: const Icon(Icons.arrow_drop_down,
                        color:
                        Colors.white), // Set dropdown icon color to white
                    dropdownColor: const Color(
                        0xff4D6159), // Set dropdown background color to green
                    onChanged: (String? newValue) {
                      setState(() {
                        provinceDropdownValue = newValue!;
                      });
                    },
                    items: provinceDropdownItems.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              color: Colors.white), // Set text color to white
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20.0), // Increase space between fields
              SizedBox(
                width: 300.0,
                height: 50,// Adjust width as needed
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      city = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter city',
                    border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(
                        color: Colors.white), // Set hint text color to white
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(
                      color: Colors.white), // Set text color to white
                ),
              ),
              const SizedBox(height: 20.0), // Increase space between fields
              Container(
                width: 300.0, // Adjust width as needed
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color:
                  const Color(0xff4D6159), // Set background color to green
                ),
                child: SingleChildScrollView(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: diseaseDropdownValue,
                      icon: const Icon(Icons.arrow_drop_down,
                          color:
                          Colors.white), // Set dropdown icon color to white
                      dropdownColor: const Color(
                          0xff4D6159), // Set dropdown background color to green
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
                                color: Colors.white), // Set text color to white
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0), // Increase space between fields
              Container(
                width: 300.0, // Adjust width as needed
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color:
                  const Color(0xff4D6159), // Set background color to green
                ),
                child: SingleChildScrollView(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: anotherDropdownValue,
                      icon: const Icon(Icons.arrow_drop_down,
                          color:
                          Colors.white), // Set dropdown icon color to white
                      dropdownColor: const Color(
                          0xff4D6159), // Set dropdown background color to green
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
                                color: Colors.white), // Set text color to white
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  height: 40.0), // Increase space between fields and button
              SizedBox(
                width: 300.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Button action
                    // Navigate to SignUpPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SignThreePage(
                          uid:widget.uid,
                          city:city,
                          province:provinceDropdownValue,
                          condition: diseaseDropdownValue,
                          status: anotherDropdownValue
                        );}),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(0.0), // Make button square
                    ),
                    backgroundColor:
                    Colors.white, // Set button background color to white
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                        color: Color(
                            0xff4D6159)), // Set button text color to green
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


