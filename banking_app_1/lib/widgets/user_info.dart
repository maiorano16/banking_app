import 'package:banking_app_1/models/user_model.dart';
import 'package:banking_app_1/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserInfoSection extends StatelessWidget {
  final Utenti user;

  const UserInfoSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Center(
          child: CircleAvatar(
            radius: 60,
            backgroundImage: const AssetImage('assets/userProfileImmage/userIcon.png'),
            backgroundColor: Colors.grey[200],
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ProfileCard(
                icon: Icons.person,
                title: 'Nome e Cognome',
                value: '${user.nome} ${user.cognome}',
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ProfileCard(
                icon: Icons.cake,
                title: 'Data di nascita',
                value: user.dataNascita,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ProfileCard(
                icon: getIconForGender(user.sesso),
                title: 'Gender',
                value: user.sesso,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ProfileCard(
                icon: Icons.work,
                title: 'Professione',
                value: user.professione,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ProfileCard(
                icon: Icons.location_on,
                title: 'Location',
                value: user.residenza,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ProfileCard(
                icon: Icons.fingerprint,
                title: 'User Id',
                value: user.userId,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

IconData getIconForGender (String sesso){
  switch(sesso){
    case 'Maschio':
    return FontAwesomeIcons.male;
    case 'Femmina': 
    return FontAwesomeIcons.female;
    default:
    return Icons.person;

  }
}