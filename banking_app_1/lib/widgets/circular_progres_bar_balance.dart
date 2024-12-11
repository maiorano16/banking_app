import 'package:circular_gradient_progress/circular_gradient_progress.dart';
import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
  @override
  _CircularProgressPageState createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage> {
  final duration = Duration(seconds: 2);

 
  final List<Color> backgroundColors = [
    Color(0xFF2196F3).withOpacity(0.2), 
    Color(0xFF4CAF50).withOpacity(0.2), 
    Color(0xFFF44336).withOpacity(0.2), 
  ];

 
  final List<List<Color>> gradientColors = [
    [Color(0xFF2196F3), Color(0xFF1976D2)], 
    [Color(0xFF4CAF50), Color(0xFF388E3C)], 
    [Color(0xFFF44336), Color(0xFFD32F2F)],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circular Gradient Progress'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: CircularGradientCombineWidget(
          size: 120, 
          duration: duration, 
          centerCircleSizeRatio: 0.05, 
          sweepAngles: const [200, 720, 860], 
          backgroundColors: backgroundColors, 
          gradientColors: gradientColors, 
        ),
      ),
    );
  }
}
