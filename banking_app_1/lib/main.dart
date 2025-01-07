import 'package:banking_app_1/pages/cardScreen.dart';
import 'package:banking_app_1/pages/mainAccountScreen.dart';
import 'package:flutter/material.dart';
import 'package:banking_app_1/pages/splashScreen.dart';
import 'package:banking_app_1/pages/userProfileScreen.dart';

void main() async {

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => MainAccountPage(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}

