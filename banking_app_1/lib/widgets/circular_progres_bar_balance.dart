import 'package:multi_circular_slider/multi_circular_slider.dart';
import 'package:flutter/material.dart';
 
class CircularBar extends StatelessWidget {
  final List<double> values;
  final List<Color> colors; 
  final String label; 
  final String innerText;

  const CircularBar({
    Key? key,
    required this.values,
    required this.colors,
    required this.label,
    required this.innerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiCircularSlider(
      size: MediaQuery.of(context).size.width * 0.8,
      progressBarType: MultiCircularSliderType.circular,
      values: values,
      colors: colors,
      showTotalPercentage: true,
      label: label,
      animationDuration: const Duration(milliseconds: 500),
      animationCurve: Curves.easeIn,
      innerIcon: Icon(Icons.account_balance_wallet),
      innerWidget: Center(  
        child: Text(
          innerText,
          style: TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
            color: Colors.black,  
          ),
        ),
      ),
      trackColor: Colors.white,
      progressBarWidth: 52.0,
      trackWidth: 52.0,
    );
  }
}
