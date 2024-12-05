import 'dart:convert';
import 'package:flutter/services.dart';

class Balance {
  String period;
  double totalMoneyInBank;
  double totalSavings;
  double cost;


  Balance({
    required this.period,
    required this.totalMoneyInBank,
    required this.totalSavings,
    required this.cost,
  });

  factory Balance.fromJson(Map<String, dynamic> json){
    return Balance(
      period: json['period'],
      totalMoneyInBank: json['total_money_in_bank'],
      totalSavings: json['total_savings'],
      cost: json['expense_cost'],
    );
  }

}

Future<List<Balance>> loadBalanceFromJson() async{
  final String response = await rootBundle.loadString('assets/balance.json');
  final Map<String, dynamic> data = json.decode(response);
   final List<dynamic> balanceList = data['balances'];
  return balanceList.map((json) => Balance.fromJson(json)).toList();

}