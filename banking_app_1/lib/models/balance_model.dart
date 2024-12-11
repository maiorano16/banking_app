import 'dart:convert';
import 'package:flutter/services.dart';

class Balance {
  String period;
  double totalMoneyInBank;
  double totalSavings;
  double cost;
  String startPeriod;
  String finalPeriod;


  Balance({
    required this.period,
    required this.totalMoneyInBank,
    required this.totalSavings,
    required this.cost,
    required this.startPeriod,
    required this.finalPeriod,
  });


  factory Balance.fromJson(Map<String, dynamic> json){
    return Balance(
      period: json['period'],
      totalMoneyInBank: (json['total_money_in_bank'] as num).toDouble(),
      totalSavings: (json['total_savings'] as num).toDouble(),
      cost: (json['expense_cost'] as num).toDouble(),
      startPeriod: json['start_period'],
      finalPeriod: json['final_period'],
    );
  }

  double get balance => totalMoneyInBank + totalSavings - cost;

}

Future<List<Balance>> loadBalanceFromJson() async{
  final String response = await rootBundle.loadString('assets/balance.json');
  final Map<String, dynamic> data = json.decode(response);
   final List<dynamic> balanceList = data['balances'];
  return balanceList.map((json) => Balance.fromJson(json)).toList();

}