import 'dart:convert';
import 'package:banking_app_1/models/transaction_model.dart';
import 'package:flutter/services.dart';

class Carta {
  String tipoCarta;
  String circuito;
  String scadenzaCarta;
  double saldoCarta;
  String cardId;
  String numeroCarta;
  String tipoAccount;
  String iban;
  List<Transazioni> transazioni = [];

  Carta({
    required this.tipoCarta,
    required this.circuito,
    required this.scadenzaCarta, 
    required this.saldoCarta,
    required this.cardId,
    required this.numeroCarta,
    required this.tipoAccount,
    required this.iban,
  });

  factory Carta.fromJson(Map<String, dynamic> json){
    return Carta(
      tipoCarta: json['tipo_carta'],
      circuito: json['circuito'],
      scadenzaCarta: json['scadenza_carta'],
      saldoCarta: json['saldo_carta'],
      cardId: json['cardId'],
      numeroCarta: json['numero_carta'],
      tipoAccount: json['type_of_account'],
      iban: json['iban'],

    );
  }
}

Future<List<Carta>> loadCarteFromJson() async{
  final String response = await rootBundle.loadString('assets/card.json');
  final Map<String, dynamic> data = json.decode(response);
   final List<dynamic> carteList = data['cards'];
  return carteList.map((json) => Carta.fromJson(json)).toList();

}