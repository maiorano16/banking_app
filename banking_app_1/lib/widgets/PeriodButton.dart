import 'package:flutter/material.dart';

class PeriodButton extends StatelessWidget {
  final String label;
  final String period;
  final VoidCallback onPressed;
  final bool isSelected; 

  const PeriodButton({
    required this.label,
    required this.period,
    required this.onPressed,
    required this.isSelected, 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Colors.blueAccent 
            : Colors.grey,      
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.transparent, 
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black, 
        ),
      ),
    );
  }
}
