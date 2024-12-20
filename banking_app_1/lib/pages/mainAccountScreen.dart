import 'dart:convert';
import 'package:banking_app_1/models/mainAccountAnnualTransaction_model.dart'; 
import 'package:banking_app_1/utility/get_logo.dart';
import 'package:banking_app_1/widgets/main_transaction_annual.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:banking_app_1/models/card_model.dart';

class MainAccountPage extends StatefulWidget {
  const MainAccountPage({Key? key}) : super(key: key);

  @override
  _MainAccountPageState createState() => _MainAccountPageState();
}

class _MainAccountPageState extends State<MainAccountPage> {
  List<Carta> carte = [];
  List<AnnualMainAccountTransaction> transactions = [];  
  String selectedCardId = '';

  @override
  void initState() {
    super.initState();
    _loadCarteFromJson();
    _loadTransactionsFromJson();  
  }

  Future<void> _loadCarteFromJson() async {
    final String response = await rootBundle.loadString('assets/fileJson/card.json');
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> carteList = data['cards'];
    
    setState(() {
      carte = carteList.map((json) => Carta.fromJson(json)).toList();
    });
  }

  Future<void> _loadTransactionsFromJson() async {
    final String response = await rootBundle.loadString('assets/fileJson/mainAccountTransactionAnnual.json');  // Ensure the correct JSON file is loaded
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> monthsList = data['months'];


    List<AnnualMainAccountTransaction> allTransactions = [];
    for (var month in monthsList) {
      for (var transaction in month['annualMainAccountTransaction']) {
        allTransactions.add(AnnualMainAccountTransaction.fromJson(transaction));
      }
    }

    setState(() {
      transactions = allTransactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainAccountCards = carte.where((card) => card.tipoAccount == 'Main account').toList();
    if (mainAccountCards.isNotEmpty) {
      final mainCard = mainAccountCards.first;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Main Account Card'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 200,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 32),
                                Text(
                                  '\$${mainCard.saldoCarta}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  '${mainCard.numeroCarta}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 150,
                            right: 16,
                            child: Text(
                              mainCard.scadenzaCarta,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 16,
                            child: Image.asset(
                              getLogoForCards(mainCard.circuito),
                              width: 60,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            top: 150,
                            left: 15,
                            child: Text(
                              mainCard.tipoCarta,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              Expanded(
  child: transactions.isEmpty
      ? Center(child: Text('No transactions available.'))
      : MainTransactionsListPage(transactions: transactions), 
),

            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Main Account Cards'),
        ),
        body: Center(
          child: const Text('No main account cards available'),
        ),
      );
    }
  }
}
