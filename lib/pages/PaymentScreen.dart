// import "package:firebase_auth/firebase_auth.dart";
// import "package:flutter/cupertino.dart";
// import "package:flutter/material.dart";
// import "package:flutter/widgets.dart";
// import "package:health_anixi/State/PaymentScreenState.dart";
// import "package:health_anixi/pages/newfeed.dart";
// import "package:url_launcher/url_launcher.dart";

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {

//   TextEditingController amount = TextEditingController();

//   Color myColor = const Color.fromARGB(255, 74, 95, 86);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//             child: Stack(
//                 children: [
//           Container(
//             color: myColor, // Set background color here
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           const Align(
//               alignment: Alignment.topCenter,
//               child: FractionalTranslation(
//                 translation: Offset(0.0, -0.1),
//                 child: Image(
//                   height: 500,
//                   width: 500,
//                   image: AssetImage('assets/images/Anixihealth.png'),
//                 ),
//               )),
//           Align(
//             alignment: Alignment.center,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 200,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(10.0),
//                   child: Container(
//                       width: 300,
//                       height: 50,
//                       child: TextFormField(
//                         controller: amount,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           hintText: 'Donation Amount',
//                           hintStyle: TextStyle(color: Colors.white),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.white,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.white,
//                               width: 2.0,
//                             ),
//                           ),
//                         ),
//                         style: TextStyle(color: Colors.white),
//                       )),
//                 ),
//                 GestureDetector(
//                   onTap: () async{
//                     try {
//                       String uid = FirebaseAuth.instance.currentUser!.uid;
//                       DateTime time = DateTime.now();
//                       String reference = uid.substring(0,20) + " : "+time.toString().substring(0,20);
//                       PaymentScreenState payment =
//                       PaymentScreenState(amount: double.parse(
//                           amount.text),
//                           reference: reference,
//                         uid:uid
//                       );
//                       await payment.postPayment();
//                       Uri? _url = Uri.parse(payment.postPaymentUrl);
//                       if(payment.paymentStatusResponse!="Complete"){
//                         _launchUrl(_url!);
//                         amount.clear();
//                       }
//                       else{
//                         amount.clear();
//                         Navigator.push(context, MaterialPageRoute(builder: (context){
//                           return NewsFeedPage();
//                         }));
//                       }

//                     }
//                     catch(e){
//                       return showDialog(
//                           context: context,
//                           builder: (BuildContext context){
//                             return AlertDialog(
//                                 title:Text('Error'),
//                                 content:Text(e.toString()),
//                                 actions:<Widget>[
//                                   TextButton(
//                                       onPressed:(){

//                                         amount.clear();
//                                         Navigator.of(context).pop();//
//                                       },
//                                       child:Text("Okay")
//                                   )
//                                 ]

//                             );
//                           }
//                       );
//                     }
//                   },
//                   child: Container(
//                     height: 55,
//                     width: 300,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(
//                           255, 243, 249, 253), // Background color
//                       borderRadius: BorderRadius.circular(0), // Rounded corners
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Donate',
//                         style: TextStyle(
//                           color: myColor, // Text color
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // FloatingActionButton(
//                 //   onPressed: () async {
//                 //     // await payment.postPayment();
//                 //     // Uri? _url = Uri.parse(payment.postPaymentUrl);
//                 //     // _launchUrl(_url!);
//                 //   },
//                 //   child: Text("Make Payment"),
//                 // ),
//               ],
//             ),
//           )
//         ])));
//   }

//   Future<void> _launchUrl(Uri? _url) async {
//     if (!await launchUrl(_url!)) {
//       throw Exception('Could not launch $_url');
//     }
//   }
// }