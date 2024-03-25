
import 'package:flutter/material.dart';
import 'package:health_anixi/State/loginState.dart';
import 'package:health_anixi/State/signup_threeState.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:health_anixi/pages/login.dart';

class SignThreePage extends StatefulWidget {
  late String uid;
  late String province;
  late String city;
  late String condition;
  late String status;

  SignThreePage({
    required this.uid,
    required this.city,
    required this.condition,
    required this.province,
    required this.status,
  });

  @override
  State <SignThreePage> createState() =>  _SignThreePageState();
}

class  _SignThreePageState extends State <SignThreePage> {
  final List<String> genderDropdownItems = [
    'Gender',
    'Male',
    'Female',
    'Other',
  ];
  String genderDropdownValue = 'Gender';
  String selectedDate = ''; // Variable to store the selected date
  bool popiaChecked = false;
  bool termsChecked = false;
  final TextEditingController username = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedDate = picked.toString();
      });
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4D6159),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Anixihealth.png', // Replace with your logo image path
                height: 250,
                width: 400,
                // fit: BoxFit.cover,
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: username,

                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: const TextStyle(color: Colors.white),
                    fillColor: const Color(0xff4D6159),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  _selectDate(context); // Show calendar picker
                },
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xff4D6159),
                    borderRadius: BorderRadius.circular(0.0),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                          child: Text(
                            selectedDate.isEmpty ? 'Birthday' : selectedDate.split(' ')[0],
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: 300.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: const Color(0xff4D6159),
                ),
                child: SingleChildScrollView(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: genderDropdownValue,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
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
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _launchURL('https://anixihealth.com/app/api/signup/popia');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'POPIA Disclaimer',
                          style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                        ),
                        const SizedBox(width: 8),
                        Checkbox(
                          value: popiaChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              popiaChecked = value!;
                            });
                          },
                          activeColor: Colors.white,
                          checkColor: const Color(0xff4D6159),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      _launchURL('https://anixihealth.com/app/api/signup/terms_condtions');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Terms and Conditions',
                          style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                        ),
                        const SizedBox(width: 8),
                        Checkbox(
                          value: termsChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              termsChecked = value!;
                            });
                          },
                          activeColor: Colors.white,
                          checkColor: const Color(0xff4D6159),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async{
                        // Handle sign up button press



                        if(popiaChecked&&termsChecked){
                          await signup_threeState().uploadUserData(
                              uid: widget.uid,
                              province: widget.province,
                              city: widget.city,
                              condition: widget.condition,
                              status: widget.status,
                              username: username.text,
                              birthday: selectedDate,
                              gender: genderDropdownValue
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context){
                              return ChangeNotifierProvider.value(
                                value:loginState(),
                                  child: myLogin()
                              );
                            }),
                          );
                          //Sign user up
                        }
                        else{
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Text('Error'),
                                    content: Text("Please check boxes to continue"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {

                                            Navigator.of(context)
                                                .pop(); //
                                          },
                                          child: Text("Okay")
                                      )
                                    ]

                                );
                              }
                          );
                        }


                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                      child: const Text('Sign Up', style: TextStyle(color: Color(0xff4D6159))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
