import 'package:banking_app_1/models/balance_model.dart';
import 'package:banking_app_1/widgets/circular_progres_bar_balance.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatelessWidget {
  final List<Balance> balances;

  BalancePage({required this.balances});

  List<double> _calculatePercentages(Balance balance) {
    double total = balance.totalMoneyInBank + balance.totalSavings + balance.cost;
    double moneyInBankPercentage = balance.totalMoneyInBank / total;
    double savingsPercentage = balance.totalSavings / total;
    double expensePercentage = balance.cost / total;

    return [moneyInBankPercentage, savingsPercentage, expensePercentage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bilancio Attuale',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: balances.length,
                itemBuilder: (context, index) {
                  final balance = balances[index];
                  List<double> percentages = _calculatePercentages(balance);

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        '${balance.period.capitalize()} Period',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: CircularBar(
                              values: percentages,
                              colors: [
                                Color(0xFF29D3E8), 
                                Color(0xFF18C737), 
                                Color(0xFFFFCC05), 
                              ],
                              label: 'Bilancio per ${balance.period.capitalize()}',
                              innerText: '${(percentages[0] * 100).toStringAsFixed(1)}%',
                            ),
                          ),
                          Text('Totale denaro in banca: €${balance.totalMoneyInBank.toStringAsFixed(2)}'),
                          Text('Risparmi totali: €${balance.totalSavings.toStringAsFixed(2)}'),
                          Text('Spese: €${balance.cost.toStringAsFixed(2)}'),
                          SizedBox(height: 8),
                          Text(
                            'Saldo: €${balance.balance.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: balance.balance >= 0 ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringCapitalization on String {
  String capitalize() {
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }
}
