import 'package:banking_app_1/pages/balanceScreen.dart';
import 'package:banking_app_1/pages/cardScreen.dart';
import 'package:banking_app_1/pages/mainAccountScreen.dart';
import 'package:banking_app_1/pages/userProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      // Transizione con Fade e Scale
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainAccountPage()),
      );  // Fixed the missing comma here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.scale(
          scale: 0.5,
          child: Lottie.asset('assets/lottie/splash_screen_animation.json'),
        ),
      ),
    );
  }
}
