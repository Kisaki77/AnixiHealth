import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_anixi/Navigate/Wrapper.dart';
import 'package:health_anixi/State/loginState.dart';
import 'package:health_anixi/pages/PaymentScreen.dart';
import 'package:health_anixi/pages/VideoUpload.dart';
import 'package:health_anixi/pages/login.dart';
import 'package:health_anixi/pages/newfeed.dart';
import 'package:health_anixi/pages/screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_anixi/pages/signup_two.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase based on the platform
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: 'AIzaSyDr-9xMQjTBMKOQ-G5yCrWDLNo2qTK3olA', 
      appId: '1:208342776230:android:905a409a523eef50f97767', 
    messagingSenderId: '208342776230',
          storageBucket: "anixii-project.appspot.com",
    projectId: 'anixii-project',),
      );
    } else if (Platform.isIOS) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: 'AIzaSyBC8KC460JH4zihV6apQH5wzEAxIFW8Ub4',
          appId: '1:208342776230:ios:472e891fa0a9e836f97767',
          messagingSenderId: '208342776230',
          storageBucket: "anixii-project.appspot.com",
          projectId: 'anixii-project',
        ),
      );
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
     // home: const MyScreen(),
      home:StreamProvider<User?>.value(
        initialData: null,
        value: FirebaseAuth.instance.authStateChanges(),
          child: Wrapper()
      ),
      routes: {
        '/login': (context) => myLogin(),
        '/home': (context) => NewsFeedPage(),
      },
    );
  }
}
