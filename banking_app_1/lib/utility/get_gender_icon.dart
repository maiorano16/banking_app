import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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