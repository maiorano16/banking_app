import 'package:banking_app_1/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileRow extends StatelessWidget {
  final List<Map<String, dynamic>> infoList;

  const ProfileRow({required this.infoList});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: infoList.map((info) {
        return Expanded(
          child: ProfileCard(
            icon: info['icon'],
            title: info['title'],
            value: info['value'],
          ),
        );
      }).toList(),
    );
  }
}
