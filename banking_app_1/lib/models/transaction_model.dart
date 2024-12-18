import 'dart:convert';
import 'package:flutter/services.dart';

class Transaction {
  String cardId;
  String transactionNumber;
  String typeOfTransaction;
  String service;
  String dateOfTransaction;
  String status;
  String flow;
  double costOfTransaction;

  Transaction({
    required this.cardId,
    required this.transactionNumber,
    required this.typeOfTransaction,
    required this.service,
    required this.dateOfTransaction,
    required this.status,
    required this.flow,
    required this.costOfTransaction,
  });

  factory Transaction.fromJson(Map<String, dynamic> json){
    return Transaction(
      cardId: json['card_id'],
      transactionNumber: json['transaction_number'],
      typeOfTransaction: json['transaction_type'],
      service: json['service_type'],
      dateOfTransaction: json['transaction_date'],
      status: json['status'],
      flow: json['flow'],
      costOfTransaction: json['transaction_cost'],
    );
  }

}
Future<List<Transaction>> loadTransactionFromJson() async {
  final String response = await rootBundle.loadString('assets/fileJson/transaction.json');
  final Map<String, dynamic> data = json.decode(response);
  final List<dynamic> transactionsList = data['transactions'];
  return transactionsList.map((json) => Transaction.fromJson(json)).toList();
}
