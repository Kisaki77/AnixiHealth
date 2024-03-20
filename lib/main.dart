import 'dart:io';

import 'package:anixii_health/pages/login.dart';
import 'package:anixii_health/pages/newfeed.dart';
import 'package:anixii_health/pages/screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    projectId: 'anixii-project',),
      );
    } else if (Platform.isIOS) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: 'AIzaSyBC8KC460JH4zihV6apQH5wzEAxIFW8Ub4',
          appId: '1:208342776230:ios:472e891fa0a9e836f97767',
          messagingSenderId: '208342776230',
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
      home: const MyScreen(),
      routes: {
        '/login': (context) => myLogin(),
        '/home': (context) => MyHomePage(),
      },
    );
  }
}
