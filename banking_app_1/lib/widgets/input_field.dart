import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final String? Function(String?) validator;
  final TextInputType keyboardType;

  const InputField({
    Key? key,
    required this.labelText,
    required this.onChanged,
    required this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: labelText),
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: validator,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
