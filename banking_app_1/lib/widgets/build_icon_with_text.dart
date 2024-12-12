import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  final String text;
  final Color iconColor;

  const IconWithText({
    Key? key,
    required this.text,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: iconColor,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
