import 'package:banking_app_1/models/user_model.dart';
import 'package:banking_app_1/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class ExtraInfoSection extends StatelessWidget {
  final Utenti user;
  final bool showMoreInfo;

  const ExtraInfoSection({
    required this.user,
    required this.showMoreInfo,
  });

  @override
  Widget build(BuildContext context) {
    if (!showMoreInfo) return SizedBox.shrink();

    return Column(
      children: [
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
            SizedBox(width: 10),
            Expanded(
              child: ProfileCard(
                icon: Icons.calendar_month,
                title: 'Data di nascita',
                value: user.dataNascita,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ProfileCard(
                icon: Icons.location_city,
                title: 'Luogo di nascita',
                value: user.luogoNascita,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
