import 'dart:convert';
import 'package:flutter/services.dart';

class Utenti {
  String nome;
  String cognome;
  String dataNascita;
  String luogoNascita;
  String residenza;
  int eta;
  String professione;
  String sesso;
  String userId;

  Utenti({
    required this.nome,
    required this.cognome,
    required this.dataNascita,
    required this.luogoNascita,
    required this.residenza,
    required this.eta,
    required this.professione,
    required this.sesso,
    required this.userId,
  });

  factory Utenti.fromJson(Map<String, dynamic> json){
    return Utenti(
      nome: json['first_name'],
      cognome: json['last_name'],
      dataNascita: json['date_of_birth'],
      luogoNascita: json['place_of_birth'],
      residenza: json['residence'],
      eta: json['age'],
      professione: json['profession'],
      sesso: json['gender'],
      userId: json['user_id'], 

    );
  }
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'cognome': cognome,
      'residenza': residenza,
      'professione': professione,
      'eta': eta,
      'sesso': sesso,
      'dataNascita': dataNascita,
      'luogoNascita': luogoNascita,
      'userId': userId,
    };
  }
}


Future<List<Utenti>> loadUtentiFromJson() async{
  final String response = await rootBundle.loadString('assets/user.json');
  final Map<String, dynamic> data = json.decode(response);
   final List<dynamic> utentiList = data['users'];
  return utentiList.map((json) => Utenti.fromJson(json)).toList();

}