import 'dart:convert';
import 'package:flutter/services.dart';

class MainCardTransaction {
  String cardId;
  int transactionNumber;
  String transactionType;
  String serviceType;
  String description;
  String transactionDate;
  String currency;
  String flow;
  double transactionCost;

  MainCardTransaction({
    required this.cardId,
    required this.transactionNumber,
    required this.transactionType,
    required this.serviceType,
    required this.description,
    required this.transactionDate,
    required this.currency,
    required this.flow,
    required this.transactionCost,
  });

  Map<String, dynamic> toJson() {
    return {
      'card_id': cardId,
      'transaction_number': transactionNumber,
      'transaction_type': transactionType,
      'service_type': serviceType,
      'description': description,
      'transaction_date': transactionDate,
      'currency': currency,
      'flow': flow,
      'transaction_cost': transactionCost,
    };
  }

  factory MainCardTransaction.fromJson(Map<String, dynamic> json) {
    return MainCardTransaction(
      cardId: json['card_id'],
      transactionNumber: json['transaction_number'],
      transactionType: json['transaction_type'],
      serviceType: json['service_type'],
      description: json['description'],
      transactionDate: json['transaction_date'],
      currency: json['currency'],
      flow: json['flow'],
      transactionCost: (json['transaction_cost'] ?? 0.0).toDouble(),
    );
  }
}

class MonthlyTransactions {
  String month;
  List<MainCardTransaction> transactions;

  MonthlyTransactions({
    required this.month,
    required this.transactions,
  });

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'transactions': transactions.map((e) => e.toJson()).toList(),
    };
  }

  factory MonthlyTransactions.fromJson(Map<String, dynamic> json) {
    var transactionList = (json['transactions'] as List)
        .map((e) => MainCardTransaction.fromJson(e))
        .toList();
    return MonthlyTransactions(
      month: json['month'],
      transactions: transactionList,
    );
  }
}

class TransactionsData {
  List<MonthlyTransactions> transactions;

  TransactionsData({required this.transactions});

  Map<String, dynamic> toJson() {
    return {
      'transactions': transactions.map((e) => e.toJson()).toList(),
    };
  }

  factory TransactionsData.fromJson(Map<String, dynamic> json) {
    var transactionList = (json['transactions'] as List)
        .map((e) => MonthlyTransactions.fromJson(e))
        .toList();
    return TransactionsData(
      transactions: transactionList,
    );
  }
}

Future<TransactionsData> loadTransactionsFromJson() async {
  final String response = await rootBundle.loadString('assets/fileJson/transactions.json');
  final Map<String, dynamic> data = json.decode(response);
  return TransactionsData.fromJson(data);
}
