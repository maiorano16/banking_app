import 'dart:convert';
import 'package:flutter/services.dart';

class Bilancio {
  String periodo;
  double bilancioVerde;
  double bilancioRisparmi;
  double bilancioRosso;


  Bilancio({
    required this.periodo,
    required this.bilancioVerde,
    required this.bilancioRisparmi,
    required this.bilancioRosso,
  });

  factory Bilancio.fromJson(Map<String, dynamic> json){
    return Bilancio(
      periodo: json['period'],
      bilancioVerde: json['total_money_in_bank'],
      bilancioRisparmi: json['total_savings'],
      bilancioRosso: json['expense_cost'],
    );
  }

}

Future<List<Bilancio>> loadBilancioFromJson() async{
  final String response = await rootBundle.loadString('assets/bilancio.json');
  final Map<String, dynamic> data = json.decode(response);
   final List<dynamic> bilancioList = data['bilancio'];
  return bilancioList.map((json) => Bilancio.fromJson(json)).toList();

}