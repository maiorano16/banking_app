import 'package:banking_app_1/pages/balanceScreen.dart';
import 'package:banking_app_1/pages/cardScreen.dart';
import 'package:flutter/material.dart';

void main() {

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
      home: BalancePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}