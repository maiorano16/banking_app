import 'dart:convert';
import 'package:flutter/services.dart';

class AnnualMainAccountTransaction {
  String date;
  double amount;
  String currency;
  String category;
  String description;
  String paymentMethod;
  String? store;

  AnnualMainAccountTransaction({
    required this.date,
    required this.amount,
    required this.currency,
    required this.category,
    required this.description,
    required this.paymentMethod,
    this.store,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'amount': amount,
      'currency': currency,
      'category': category,
      'description': description,
      'payment_method': paymentMethod,
      'store': store,
    };
  }

  factory AnnualMainAccountTransaction.fromJson(Map<String, dynamic> json) {
    return AnnualMainAccountTransaction(
      date: json['date'],
      amount: json['amount'],
      currency: json['currency'],
      category: json['category'],
      description: json['description'],
      paymentMethod: json['payment_method'],
      store: json['store'],
    );
  }
}

class Month {
  String month;
  List<AnnualMainAccountTransaction> annualMainAccountTransactions;
  double totalExpense;
  double averageDailyExpense;
  Map<String, double> categories;

  Month({
    required this.month,
    required this.annualMainAccountTransactions,
    required this.totalExpense,
    required this.averageDailyExpense,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'annualMainAccountTransaction': annualMainAccountTransactions.map((t) => t.toJson()).toList(),
      'total_expense': totalExpense,
      'average_daily_expense': averageDailyExpense,
      'categories': categories,
    };
  }

  factory Month.fromJson(Map<String, dynamic> json) {
    var transactionsList = json['annualMainAccountTransaction'] as List;
    List<AnnualMainAccountTransaction> transactions = transactionsList
        .map((t) => AnnualMainAccountTransaction.fromJson(t))
        .toList();
    var categoriesMap = Map<String, double>.from(json['categories']);

    return Month(
      month: json['month'],
      annualMainAccountTransactions: transactions,
      totalExpense: json['total_expense'],
      averageDailyExpense: json['average_daily_expense'],
      categories: categoriesMap,
    );
  }
}

class AnnualReport {
  int year;
  List<Month> months;

  AnnualReport({
    required this.year,
    required this.months,
  });

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'months': months.map((m) => m.toJson()).toList(),
    };
  }

  factory AnnualReport.fromJson(Map<String, dynamic> json) {
    var monthsList = json['months'] as List;
    List<Month> months = monthsList.map((m) => Month.fromJson(m)).toList();

    return AnnualReport(
      year: json['year'],
      months: months,
    );
  }
}

Future<AnnualReport> loadAnnualReportFromJson() async {
  final String response = await rootBundle.loadString('assets/fileJson/mainAccountTransactionAnnual.json');
  final Map<String, dynamic> data = json.decode(response);
  return AnnualReport.fromJson(data);
}
