import 'dart:convert';
import 'package:flutter/services.dart';

class Transazioni {
  String cardId;
  String numeroTransazione;
  String tipoTransazione;
  String servizio;
  String dataTransazione;
  String statoTransazione;
  String direzioneTransazione;
  double costoTransazione;

  Transazioni({
    required this.cardId,
    required this.numeroTransazione,
    required this.tipoTransazione,
    required this.servizio,
    required this.dataTransazione,
    required this.statoTransazione,
    required this.direzioneTransazione,
    required this.costoTransazione,
  });

  factory Transazioni.fromJson(Map<String, dynamic> json){
    return Transazioni(
      cardId: json['card_id'],
      numeroTransazione: json['transaction_number'],
      tipoTransazione: json['transaction_type'],
      servizio: json['service_type'],
      dataTransazione: json['transaction_date'],
      statoTransazione: json['status'],
      direzioneTransazione: json['flow'],
      costoTransazione: json['transaction_cost'],
    );
  }

}
Future<List<Transazioni>> loadTransazioniFromJson() async{
  final String response = await rootBundle.loadString('assets/transaction.json');
  final Map<String, dynamic> data = json.decode(response);
   final List<dynamic> transazioniList = data['transactions'];
  return transazioniList.map((json) => Transazioni.fromJson(json)).toList();

}

Map<String, List<Transazioni>> groupTransactionsByCardId(List<Transazioni> transactions) {
  Map<String, List<Transazioni>> grouped = {};
  for (var transaction in transactions) {
    if (grouped.containsKey(transaction.cardId)) {
      grouped[transaction.cardId]!.add(transaction);
    } else {
      grouped[transaction.cardId] = [transaction];
    }
  }
  return grouped;
}