import 'package:flutter/material.dart';
import 'package:circular_gradient_progress/circular_gradient_progress.dart';

class CircularGradientProgress extends StatelessWidget {
  final List<double> sweepAngles;
  final List<List<Color>> gradientColors;
  final List<Color> backgroundColors;

  const CircularGradientProgress({
    Key? key,
    required this.sweepAngles,
    required this.gradientColors,
    required this.backgroundColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularGradientCombineWidget(
      size: 220,
      duration: const Duration(seconds: 3),
      centerCircleSizeRatio: 0.11,
      sweepAngles: sweepAngles,
      gapRatio: 0.15,
      backgroundColors: backgroundColors,
      gradientColors: gradientColors,
    );
  }
}
