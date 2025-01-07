import 'package:banking_app_1/pages/chatBot.dart';
import 'package:banking_app_1/pages/settingScreen.dart';
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
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ChatBotScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // FadeIn e Scale
            var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);
            var scaleAnimation = Tween(begin: 0.8, end: 1.0).animate(animation);
            return ScaleTransition(
              scale: scaleAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: child,
              ),
            );
          },
        ),
      );
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
